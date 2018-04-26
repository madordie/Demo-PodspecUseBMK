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

    s.dependency 'BaiduMapKit'
    s.dependency 'UMengAnalytics'
    s.pod_target_xcconfig = {
        'OTHER_LDFLAGS' => '$(inherited) -undefined dynamic_lookup',
    }
    s.prepare_command = 'sh mk_modulemap.sh Pods/UMengAnalytics Pods/BaiduMapKit'
end
