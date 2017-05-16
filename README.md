## Demo-PodspecUseBMK

百度地图SDK是静态库，当使用Swift的时候需要在`Podfile`中添加`use_frameworks!`配置项，则百度地图无法使用😭

## 实现效果

自动在私有Pods(`BMK`)中增加静态库(`BaiduMapKit`)的包含功能。

## 配置方法

这里只说需要额外更改的部分。

如果有更好的配置方法，或者此方法有什么不妥的地方(特别是添加framework这块)，请指正～

### podspec配置
```rb
s.dependency 'BaiduMapKit'
s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/BaiduMapKit/BaiduMapKit',
    'LIBRARY_SEARCH_PATHS'   => '$(inherited) $(PODS_ROOT)/BaiduMapKit/BaiduMapKit/thirdlibs',
    'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
}
```
### Podfile配置
```rb

pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    def installer.verify_no_static_framework_transitive_dependencies; end
end

post_install do |installer|
    project_location = './Pods/Pods.xcodeproj'
    # 设置使用#{framework_names}对应的target
    target_names = ['BMK']
    framework_names = [ 'BaiduMapKit' ]

    project = installer.pods_project

    framework_names.each do |framework_name|
        frameworks = project.pod_group(framework_name)
        .children
        .find { |group| group.name == 'Frameworks' }
        .children

        target_names.each do |target_name|
            target = project.targets.find { |target| target.to_s == target_name }
            frameworks_group = project.groups.find { |group| group.display_name == 'Frameworks' }
            frameworks_build_phase = target.build_phases.find { |build_phase| build_phase.to_s == 'FrameworksBuildPhase' }

            frameworks.each do |file_ref|
                frameworks_build_phase.add_file_reference(file_ref)
            end
        end
    end
end
```

## 遇到的问题

### target has transitive dependencies that include static binaries
```sh
[!] The 'Pods-BaiduMapKit-pods' target has transitive dependencies that include static binaries: (**.framework)
```
需要在工程的`Podfile`中配置：
```rb
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    def installer.verify_no_static_framework_transitive_dependencies; end
end
```
即可。

### podspace所在工程无法使用百度地图SDK，找不到头文件
需要在podspec中进行如下配置：
```rb
s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/BaiduMapKit/BaiduMapKit',
    'LIBRARY_SEARCH_PATHS'   => '$(inherited) $(PODS_ROOT)/BaiduMapKit/BaiduMapKit/thirdlibs',
    'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
}
```

需要注意的是：`FRAMEWORK_SEARCH_PATHS`、`LIBRARY_SEARCH_PATHS`俩个参数最后的路径需要根据实际的位置进行配置。

`BaiduMapKit`对于上面的两个路径就是上面的路径。

对于其他的静态库，同理即可。

### build ipa crash..
crash信息主要为`BMK`无法载入`FRAMEWORK_SEARCH_PATHS`配置的framework。
此问题主要为framework只是在search的时候指定了search path 但是当打包之后鬼知道发生了什么，这里配置的库就丢了。为此搜索了很多比如：
- [CocoaPods/Xcodeproj/Issues/#408/@jpsim](https://github.com/CocoaPods/Xcodeproj/issues/408)
- [`post_install`官方文档(内容着实太少，后搜索其API)](https://guides.cocoapods.org/syntax/podfile.html#post_install)
- [CocoaPods API](http://www.rubydoc.info/github/CocoaPods/CocoaPods/Pod)
- 等等。。

## 美中不足

### One of the two will be used. Which one is undefined.

其实ipa中含有两份百度地图相关库。

```sh
objc[22062]: Class BMSDKKeychainItemWrapper is implemented in both ~/Library/Developer/CoreSimulator/Devices/3F7A878A-C93D-40C1-87E7-44696FD4F992/data/Containers/Bundle/Application/90FB4FF0-A7C5-4454-9FE8-139542FA9BBF/BaiduMapKit-pods.app/Frameworks/BMK.framework/BMK (0x10cd5d7a8) and ~/Library/Developer/CoreSimulator/Devices/3F7A878A-C93D-40C1-87E7-44696FD4F992/data/Containers/Bundle/Application/90FB4FF0-A7C5-4454-9FE8-139542FA9BBF/BaiduMapKit-pods.app/BaiduMapKit-pods (0x10c6a63a0). One of the two will be used. Which one is undefined.
...
```
