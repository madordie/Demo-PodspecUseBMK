Pod::Spec.new do |s|
    s.name         = 'BMK'
    s.version      = '0.0.4'
    s.license      = { :type => 'MIT' }
    s.homepage     = 'http://www.fangdd.com/shanghai'
    s.author       = { 'sunjigang' => 'sunjigang@fangdd.com' }
    s.summary      = 'BMK'

    s.platform     =  :ios, '7.0'
    s.source       =  { :git => 'xx' }
    s.module_name  = 'BMK'
    s.framework    = 'UIKit'
    s.requires_arc = true

    s.source_files = 'podspec/*'

    s.dependency 'BaiduMapKit'
    s.pod_target_xcconfig = {
        'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/BaiduMapKit/BaiduMapKit',
        'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
    }
end
