#
# Be sure to run `pod lib lint LottieExtra.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LottieExtra'
  s.version          = '0.0.1'
  s.summary          = 'lottie 的扩展'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
基于lottie, 扩展图层的点击事件和添加控件至图层
                       DESC

  s.homepage         = 'https://github.com/YQqiang/LottieExtra'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yuqiang' => 'yuqiang.coder@gmail.com' }
  s.source           = { :git => 'git@github.com:YQqiang/LottieExtra.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LottieExtra/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LottieExtra' => ['LottieExtra/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'MJExtension'
  s.dependency 'lottie-ios'
  
end
