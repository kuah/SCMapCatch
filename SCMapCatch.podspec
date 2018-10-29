Pod::Spec.new do |s|
  s.name         = 'SCMapCatch'
  s.version      = '0.3.1'
  s.summary      = 'A simplified tool for NSUserDefaults , NSDictionary,NSMutableDictionary.'
  s.homepage     = 'https://github.com/Chan4iOS/SCMapCatch'
  s.author       = "CT4 => 284766710@qq.com"
  s.source       = {:git => 'https://github.com/Chan4iOS/SCMapCatch.git', :tag => "#{s.version}"}
  s.source_files = "SCMapCatch/**/*.{h,m}"
  s.requires_arc = true
  s.libraries = 'z'
  s.ios.deployment_target = '8.0'
  s.license = 'MIT'
end
