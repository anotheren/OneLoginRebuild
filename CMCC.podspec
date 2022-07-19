Pod::Spec.new do |s|
  s.name = 'CMCC'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'CMCC+Rebuild'
  s.homepage = 'https://github.com/anotheren/OneLoginRebuild'
  s.authors = { 'anotheren' => 'liudong.edward@gmail.com' }
  s.source = {
    :http => 'https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/CMCC.xcframework.zip',
    :type => 'zip',
    :sha256 => '9a49515381c6e3f24e5e75d3294205fa217cf559266d73004943ac8ab5d23696'
  }
  s.ios.deployment_target = '13.0'
  s.ios.vendored_frameworks = 'Build/CMCC.xcframework'
  s.swift_versions = ['5.6']
end
