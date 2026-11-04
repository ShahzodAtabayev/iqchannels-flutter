Pod::Spec.new do |s|
  s.name             = 'iqchannels'
  s.version          = '0.1.0'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'iqchannels/Sources/iqchannels/**/*.swift'
  s.dependency 'Flutter'
  s.dependency 'IQChannelsSwift'
  s.platform = :ios, '15.0'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # PrivacyInfo
  s.resource_bundles = {'iqchannels_privacy' => ['iqchannels/Sources/iqchannels/PrivacyInfo.xcprivacy']}
end