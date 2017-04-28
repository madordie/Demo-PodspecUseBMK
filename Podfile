platform :ios, '8.0'
use_frameworks!

target 'BaiduMapKit-pods' do
    pod 'BMK', :path => '.'
end

pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    def installer.verify_no_static_framework_transitive_dependencies; end
end
