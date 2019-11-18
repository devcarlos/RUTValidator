Pod::Spec.new do |s|
  s.name             = 'RUTValidator'
  s.version          = '0.6.0'
  s.summary          = 'RUTValidator Library'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
RUTValidator is a RUT Validator Library
                       DESC
  s.homepage         = 'https://github.com/acidfilez/RUTValidator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Carlos Alcala aka Charles Xavier (Professori)' => 'carlos.alcala@me.com' }
  #s.source           = { :path => '.' }
  s.source           = { :git => 'https://github.com/devcarlos/RUTValidator.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files     = 'Sources/**/*'
end
