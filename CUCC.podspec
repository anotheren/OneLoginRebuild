Pod::Spec.new do |s|
  s.name = 'CUCC'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'CUCC+Rebuild'
  s.homepage = 'https://github.com/anotheren/OneLoginRebuild'
  s.authors = { 'anotheren' => 'liudong.edward@gmail.com' }
  s.source = {
    :http => 'https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/CUCC.xcframework.zip',
    :type => 'zip',
    :sha256 => '4811fd0c5b043cafd28b2ca47fe432880a5d19b9c645d50cc3059a22950c6ded'
  }
  s.ios.deployment_target = '13.0'
  s.ios.vendored_frameworks = 'Build/CUCC.xcframework'
  s.swift_versions = ['5.6']
end
