require 'json'

package = JSON.parse(File.read(File.join(__dir__, '../package.json')))

Pod::Spec.new do |s|
  s.name         = "RNFaceApi"
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = { 'RegulaForensics' => 'support@regulaforensics.com' }
  s.homepage     = 'https://regulaforensics.com'

  s.source       = { :http => 'file:' + __dir__ }
  s.ios.deployment_target = '10.0.0'
  s.source_files  = "*.{h,m}"
  s.dependency 'FaceSDKBeta', '5.4.216'
  s.dependency 'React'
end
