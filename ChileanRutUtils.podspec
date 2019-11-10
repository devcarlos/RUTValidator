Pod::Spec.new do |s|
  s.name             = 'ChileanRutUtils'
  s.version          = '0.2.1'
  s.summary          = 'ChileanRutUtils Library'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
ChileanRutUtils is a RUT Validator Library
                       DESC

  s.homepage         = 'https://github.com/acidfilez/ChileanRutUtils'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Algunos Wones de Latam' => 'acidfilez@gmail.com' }
  #s.source           = { :path => '.' }
  s.source           = { :git => 'https://github.com/acidfilez/ChileanRutUtils.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files     = 'Source/**/*'
end
