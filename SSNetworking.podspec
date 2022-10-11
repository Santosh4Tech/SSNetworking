Pod::Spec.new do |spec|
  spec.name          = 'SSNetworking'
  spec.version       = '1.0.0'
  spec.license       = { :type => 'MIT' }
  spec.homepage      = 'https://github.com/Santosh4Tech/SSNetworking'
  spec.authors       = { 'Santosh Kumar Sahoo' => 'mca12.santosh@gmail.com' }
  spec.summary       = 'Light weight framework for networking for iOS.'
  spec.source        = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => spec.version }
  spec.swift_version = '5.0'
  spec.platform      = :ios, "11.0"
    spec.vendored_frameworks = 'SSNetworking.xcframework'
end
