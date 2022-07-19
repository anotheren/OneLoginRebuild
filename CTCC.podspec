Pod::Spec.new do |s|
  s.name = 'CTCC'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'CTCC+Rebuild'
  s.homepage = 'https://github.com/anotheren/OneLoginRebuild'
  s.authors = { 'anotheren' => 'liudong.edward@gmail.com' }
  s.source = {
    :http => 'https://github.com/anotheren/OneLoginRebuild/releases/download/1.0.0/CTCC.xcframework.zip',
    :type => 'zip',
    :sha256 => 'e0b96ca65970ef494ee49a591c377a207e4fd2bc3130a9cee7e785a0eba7f1c4'
  }
  s.ios.deployment_target = '13.0'
  s.ios.vendored_frameworks = 'Build/CTCC.xcframework'
  s.swift_versions = ['5.6']
  s.libraries = ['c++']
end
