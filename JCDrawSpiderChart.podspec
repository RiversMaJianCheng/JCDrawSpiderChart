Pod::Spec.new do |s|
    s.name         = 'JCDrawSpiderChart'       #名称
    s.version      = '0.0.1'                   #版本号
    s.summary      = '蜘蛛网状图'                #简短介绍，下面是详细介绍
    s.homepage     = 'https://github.com/RiversMaJianCheng/JCDrawSpiderChart'
    s.license      = 'MIT'
    s.authors      = {'majiancheng' => 'ma_jcheng@126.com'}
    s.platform     = :ios, '9.0'
    s.social_media_url = 'http://majiancheng.top'
    s.source       = {:git => 'https://github.com/RiversMaJianCheng/JCDrawSpiderChart.git', :tag => s.version}
    s.source_files =   'JCDrawSpiderChart/**/*.{h,m}'
    s.requires_arc = true
    s.frameworks = 'UIKit'
end
