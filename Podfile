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
    framework_names = [ 'BaiduMapKit' ]

    project = installer.pods_project

    framework_names.each do |framework_name|
        frameworks = project.pod_group(framework_name)
        .children
        .find { |group| group.name == 'Frameworks' }
        .children

        target_names.each do |target_name|
            target = project.targets.find { |target| target.to_s == target_name }
            frameworks_group = project.groups.find { |group| group.display_name == 'Frameworks' }
            frameworks_build_phase = target.build_phases.find { |build_phase| build_phase.to_s == 'FrameworksBuildPhase' }

            frameworks.each do |file_ref|
                frameworks_build_phase.add_file_reference(file_ref)
            end
        end
    end
end
