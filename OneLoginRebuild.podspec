Pod::Spec.new do |s|
  s.name = 'OneLoginRebuild'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'GTOneLoginSDK+Rebuild'
  s.homepage = 'https://github.com/anotheren/OneLoginRebuild'
  s.authors = { 'anotheren' => 'liudong.edward@gmail.com' }
  s.source = {
    :http => 'https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/OneLoginRebuild.xcframework.zip',
    :type => 'zip',
    :sha256 => '752fa3950238a6a8c7d361cb3e703de926c501dde241e50ff60112fa4b7d59ce'
  }
  s.ios.deployment_target = '13.0'
  s.ios.vendored_frameworks = 'Build/OneLoginRebuild.xcframework'
  s.swift_versions = ['5.6']
  s.frameworks = ['UIKit', 'Network', 'CFNetwork', 'Foundation', 'CoreTelephony', 'SystemConfiguration']
  s.libraries = ['z', 'c++']
end
