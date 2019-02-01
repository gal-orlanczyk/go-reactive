Pod::Spec.new do |s|
  s.name             = 'GoReactive'
  s.version          = '0.1.0'
  s.summary          = 'Simple yet powerful observable pattern framework'
  s.description      = 'Provides a simple and powerful api for observable pattern, can also be extended easily'
  s.homepage         = 'https://github.com/gal-orlanczyk/go-reactive'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gal Orlanczyk' => 'gal.orlanczyk@outlook.com' }
  s.source           = { :git => 'https://github.com/gal-orlanczyk/go-reactive.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.frameworks = ['UIKit', 'XCTest']
  s.source_files = 'Sources/**/*'
end
