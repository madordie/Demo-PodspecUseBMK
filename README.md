# Demo-PodspecUseBMK
百度地图SDK是静态库，当使用Swift的时候需要在`Podfile`中添加`use_frameworks!`配置项，则百度地图无法使用😭

# 遇到的问题

## target has transitive dependencies that include static binaries
```
[!] The 'Pods-BaiduMapKit-pods' target has transitive dependencies that include static binaries: (**.framework)
```
需要在工程的`Podfile`中配置：
```
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    def installer.verify_no_static_framework_transitive_dependencies; end
end
```
即可。

## podspace所在工程无法使用百度地图SDK，找不到头文件
需要在podspec中进行如下配置：
```
s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/BaiduMapKit/BaiduMapKit',
    'LIBRARY_SEARCH_PATHS'   => '$(inherited) $(PODS_ROOT)/BaiduMapKit/BaiduMapKit/thirdlibs',
    'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
}
```

需要注意的是：`FRAMEWORK_SEARCH_PATHS`、`LIBRARY_SEARCH_PATHS`俩个参数最后的路径需要根据实际的位置进行配置。

`BaiduMapKit`对于上面的两个路径就是上面的路径。

对于其他的静态库，同理即可。
