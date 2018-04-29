
#
#  Be sure to run `pod spec lint JCDrawSpiderChart.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


s.name         = "JCDrawSpiderChart"
s.version      = "0.0.2"
s.summary      = "动态蜘蛛网状图"
s.description  = "根据传入的参数，动态绘制蜘蛛网状图"

s.homepage     = "https://github.com/RiversMaJianCheng/JCDrawSpiderChart"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

s.license      = "MIT"
s.author             = { "majiancheng" => "“ma_jcheng@126.com”" }

# s.platform     = :ios
s.platform     = :ios, "9.0"

s.source       = { :git => "https://github.com/RiversMaJianCheng/JCDrawSpiderChart.git", :tag => "#{s.version}" }
s.source_files  = "JCDrawSpiderChart", "JCDrawSpiderChart/**/*.{h,m}"
#s.exclude_files = "Classes/Exclude"
s.requires_arc = true
s.framework      = "UIKit"
# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
# s.dependency "JSONKit", "~> 1.4"

end
