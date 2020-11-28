#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint beatscratch_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'beatscratch_plugin'
  s.version          = '0.0.1'
  s.summary          = 'BeatScratch Music Modeling, Sequencers and Synthesizers'
  s.description      = <<-DESC
A Flutter plugin that bundles AudioKit, FluidSynth and other synthesizers as appropriate and provides a common Protobuf-based interface to all of them.
                       DESC
  s.homepage         = 'http://beatscratch.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.dependency 'AudioKit/Core', '~> 4.11.1'
  s.dependency 'SwiftProtobuf', '~> 1.13.0'
  s.static_framework

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
