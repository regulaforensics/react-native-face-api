require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))
source = File.join(__dir__, 'ios')

Pod::Spec.new do |s|
  s.name         = 'RNFaceApi'
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = { 'RegulaForensics' => 'support@regulaforensics.com' }
  s.homepage     = 'https://regulaforensics.com'

  s.source       = { http: "file:#{source}" }
  s.ios.deployment_target = '13.0'
  s.source_files = 'ios/**/*.{h,m}'
  s.dependency 'FaceSDKNightly', '6.4.2517'
  s.dependency 'React'
end
