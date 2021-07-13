# react-native-axa-mobile-sdk.podspec

require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "@broadcom/react-native-axa-mobile-sdk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  CA App Experience Analytic native SDK's react native supplement for using custom metrics
                   DESC
  s.homepage     = "https://github.com/CA-Application-Performance-Management/ReactNativeAxaMobileSdk"
  # brief license entry:
   s.license    = { :type => "Apache License 2.0", :file => "LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/CA-Application-Performance-Management/ReactNativeAxaMobileSdk.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."
end

