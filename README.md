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
    'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
}
```
### Podfile配置
```rb
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end
```
