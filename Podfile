source 'https://cdn.cocoapods.org/'
source 'https://github.com/drumpads24/DrumPads24Specs.git'

install! 'cocoapods', :warn_for_unused_master_specs_repo => false

platform :ios, '13.0'

use_modular_headers!

def uiPods
  pod 'DrumPads24UICore'
end

target "sampler" do 
  uiPods
 
  pod 'DrumPads24Core'
#  pod 'DrumPads24AnalyticsTracker'
  pod 'DrumPads24UICore'
#  pod 'DrumPads24LocalizationCore'
end

target "samplerUI" do
  uiPods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
    target.build_configurations.each do |config|
       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
