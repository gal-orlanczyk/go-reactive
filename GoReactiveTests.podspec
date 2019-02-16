Pod::Spec.new do |s|
  s.name             = 'GoReactiveTests'
  s.version          = '0.1.1'
  s.summary          = 'Tests tools for GoReactive'
  s.description      = 'Provides test tools for GoReactive'
  s.homepage         = 'https://github.com/gal-orlanczyk/go-reactive'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gal Orlanczyk' => 'gal.orlanczyk@outlook.com' }
  s.source           = { :git => 'https://github.com/gal-orlanczyk/go-reactive.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.frameworks = ['XCTest']
  s.source_files = 'TestUtilsSources/**/*'
  s.dependency 'GoReactive'
end
