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
    'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
}
s.prepare_command = 'sh mk_modulemap.sh Pods/BaiduMapKit'
```
### Podfile配置
```rb
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end
```

## 引申问题

`BaiduMapKit`、`UMengAnalytics`等一些`framework`中因为不含`Modules/module.modulemap`，所以无法在swift中import。

在[DianQK的基于 CocoaPods 进行 iOS 开发](https://blog.dianqk.org/2017/05/01/dev-on-pod/#创建-module-modulemap)说明了这个问题，并提供了解决方案，可以参考。

由于其重新定义[podspec](https://raw.githubusercontent.com/DianQK/UMengAnalytics-NO-IDFA-Module/master/UMengAnalytics-NO-IDFA.podspec)的方案需要在库更新的时候在此更新该`podspec`，所以又写了一个简单的脚本做这件事情。

该脚本可以直接配置在将这样的pod作为`dependency`的`podspec`中，写做:
```rb
s.prepare_command = 'sh mk_modulemap.sh Pods/BaiduMapKit Pods/UMengAnalytics'
```
这样就可以自动补全`framework`缺失的`Modules/module.modulemap`啦～～

## mk_modulemap.sh说明

### 功能

脚本会遍历每个目录下所有的framework，并根据`.framework/Headers`补全其中缺失的`Modules/module.modulemap`。

`Modules/module.modulemap`文件格式为：
```
framework module MODULE {
    header "xxx.h"
    ...
    export *
}

```

### 参数

一个或多个目录。

### PS

`shell`功底较差，功能可用，脚本不忍直视
