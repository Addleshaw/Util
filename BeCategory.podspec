Pod::Spec.new do |s|
    s.name         = 'BeCategory'
    s.version      = '0.0.1'
    s.summary      = 'just some Category'
    s.homepage     = 'https://github.com/Addleshaw/Util.git'
    s.license      = 'MIT'
    s.authors      = {'Bernie' => '657483216@qq.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/Addleshaw/Util.git', :tag => s.version}
    s.source_files = 'Sources/*.{h,m}'
    #s.resource     = 'MJRefresh/MJRefresh.bundle'
    s.requires_arc = true
end


