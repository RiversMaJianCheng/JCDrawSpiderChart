#
#  Be sure to run `pod spec lint JCDrawSpiderChart.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "JCDrawSpiderChart"
  s.version      = "0.0.1"
  s.summary      = "A short description of JCDrawSpiderChart."
  s.description  = "description"

  s.homepage     = "https://github.com/RiversMaJianCheng/JCDrawSpiderChart"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  s.author             = { "majiancheng" => "“ma_jcheng@126.com”" }

  # s.platform     = :ios
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/RiversMaJianCheng/JCDrawSpiderChart.git", :tag => "#{s.version}" }
  s.source_files  = "JCDrawSpider", "JCDrawSpider/**/*.{h,m}"
    #s.exclude_files = "Classes/Exclude"
   s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
