Pod::Spec.new do |s|
    s.name         = 'BMK'
    s.version      = '0.0.1'
    s.license      = { :type => 'MIT' }
    s.homepage     = 'https://www.github.com/madordie'
    s.author       = { 'sunjigang' => 'keith_127@126.com' }
    s.summary      = 'BMK'

    s.platform     =  :ios, '7.0'
    s.source       =  { :git => 'xx' }
    s.module_name  = 'BMK'
    s.framework    = 'UIKit'
    s.requires_arc = true

    s.source_files = 'podspec/*'

    s.dependency 'DeviceDNA'
    s.dependency 'BaiduMapKit'
    s.dependency 'PLShortVideoKit'
    s.dependency 'UMengAnalytics'
    s.pod_target_xcconfig = {
#        'ENABLE_BITCODE' => 'NO',
#        'SWIFT_VERSION' => '4.0',
        'OTHER_LDFLAGS' => '$(inherited) -undefined dynamic_lookup',
#        'FRAMEWORK_SEARCH_PATHS' => '$(inherited) ${PODS_ROOT}/BaiduMapKit/BaiduMapKit'
    }
end
