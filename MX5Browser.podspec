#
#  Be sure to run `pod spec lint MX5Browser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "MX5Browser"
  s.version      = "0.1.4"
  s.summary      = "MX5Browser是基于WKWebView内核的app内置web浏览器."
  s.homepage     = "https://github.com/kingly09/MX5Browser"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "kingly" => "libintm@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/kingly09/MX5Browser.git", :tag => s.version.to_s }
  s.social_media_url   = "https://github.com/kingly09"
  s.source_files = 'MX5Browser/**/*'
  s.framework    = "UIKit"
  s.requires_arc = true
  s.dependency "Reachability", "~> 3.2"
  s.dependency "KYMenu"
  s.dependency "CocoaLumberjack", "~> 3.3.0"
  s.dependency "YYKit", "~> 1.0.9"

end
