#
# Be sure to run `pod lib lint RYLSJRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RYLSJRouter'
  s.version          = '0.1.0'
  s.summary          = 'RYLSJRouter'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "RYLSJRouter 路由和静态库集合"

  s.homepage         = 'https://github.com/Runyalsj/RYLSJRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Runyalsj' => 'Runya_lsj@163.com' }
  s.source           = { :git => 'https://github.com/Runyalsj/RYLSJRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  if ENV['RYLSJRouter']
      s.source_files = 'RYLSJRouter/Classes/**/*'
      else
      s.source_files = 'RYLSJRouter/Classes/**/*.h'
      s.ios.vendored_frameworks = 'RYLSJRouter/Products/GDKit_Router.framework'
  end
  
  # s.resource_bundles = {
  #   'RYLSJRouter' => ['RYLSJRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
