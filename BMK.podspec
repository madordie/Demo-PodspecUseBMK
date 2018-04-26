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
    s.prepare_command = <<-EOF
        cd Pods/UMengAnalytics/
        cd $(ls)/UMMobClick.framework
        if [ ! -d "Modules" ]; then
            mkdir Modules
        fi
        cd Modules
        touch module.modulemap
        cat <<-EOF > module.modulemap
        framework module UMMobClick {
            header "MobClick.h"
            header "MobClickGameAnalytics.h"
            header "MobClickSocialAnalytics.h"

            export *

            link "z"
            link "sqlite3"
        }
        \EOF
    EOF
end
