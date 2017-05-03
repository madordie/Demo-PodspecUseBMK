platform :ios, '8.0'
use_frameworks!

target 'BaiduMapKit-pods' do
    pod 'BMK', :path => '.'
end

pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    def installer.verify_no_static_framework_transitive_dependencies; end
end

post_install do |installer|
    project_location = './Pods/Pods.xcodeproj'
    # 设置使用#{framework_names}对应的target
    target_names = ['BMK']
    # #{framework_names}对应#{Pods}的路径
    framework_root = './BaiduMapKit/BaiduMapKit'
    framework_names = [
    'BaiduMapAPI_Base.framework',
    'BaiduMapAPI_Cloud.framework',
    'BaiduMapAPI_Location.framework',
    'BaiduMapAPI_Map.framework',
    'BaiduMapAPI_Radar.framework',
    'BaiduMapAPI_Search.framework',
    'BaiduMapAPI_Utils.framework',
    ]

    project = installer.pods_project

    target_names.each do |target_name|
        target = project.targets.find { |target| target.to_s == target_name }
        frameworks_group = project.groups.find { |group| group.display_name == 'Frameworks' }
        frameworks_build_phase = target.build_phases.find { |build_phase| build_phase.to_s == 'FrameworksBuildPhase' }

        # Add framework to target as "Embedded Frameworks"
        framework_names.each do |framework_name|
            framework_ref = frameworks_group.new_file("#{framework_root}/#{framework_name}")
            frameworks_build_phase.add_file_reference(framework_ref)
        end
    end
end
