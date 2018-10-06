# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SimpleValidation' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SimpleValidation
  pod 'RxSwift',   :git =>  'https://github.com/ReactiveX/RxSwift.git'
  pod 'RxCocoa',   :git =>  'https://github.com/ReactiveX/RxSwift.git'
  # pod 'SwiftLint',  #SwiftLint版本不是最新，使用安装包方式配置swiftlint：
  #指定github路径安装之后没有swiftlint二进制文件:git =>  'https://github.com/realm/SwiftLint.git'
 
 target 'SimpleValidationTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SimpleValidationUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if target.name == 'RxSwift'
                if config.name == 'Debug'
                    puts "Playground使用的库名: #{target.name}"
                    puts "修改之前的配置：#{config.build_settings['CONFIGURATION_BUILD_DIR'].inspect}"
                    config.build_settings['PODS_CONFIGURATION_BUILD_DIR'] ||= '$PODS_CONFIGURATION_BUILD_DIR'
                    puts "修改之前的配置：#{config.build_settings['CONFIGURATION_BUILD_DIR'].inspect}"
                    
                    puts "修改之前的配置：#{config.build_settings['OTHER_SWIFT_FLAGS'].inspect}"
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                    puts "修改之后的配置：#{config.build_settings['OTHER_SWIFT_FLAGS'].inspect}"
                end
            end
        end
    end
end
