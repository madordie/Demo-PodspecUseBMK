platform :ios, '8.0'
use_frameworks!

target 'BaiduMapKit-pods' do
    pod 'BMK', :path => '.'
end

# 此处应该有别的方法配置
pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    def installer.verify_no_static_framework_transitive_dependencies; end
end
