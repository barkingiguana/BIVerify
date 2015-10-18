Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.name         = "BIVerify"
  s.version      = "0.0.3"
  s.summary      = "Port of barkingiguana/verify to Swift"
  s.homepage     = "http://github.com/barkingiguana/BIVerify"
  s.license      = "MIT"
  s.author       = { "Craig R Webster" => "craig@barkingiguana.com" }
  s.source       = { :git => "https://github.com/barkingiguana/BIVerify.git", :tag => s.version }
  s.source_files = "BIVerify/**/*.swift"

  s.dependency "CryptoSwift", "~> 0.1"
end
