Pod::Spec.new do |s|
  s.name         = "StylableUIKit"
  s.version      = "1.0.0"
  s.summary      = "A protocol for applying design to iOS apps following Atomic Design Theory"
  s.description  = <<-DESC
  A library which allows iOS apps to be skinned / themed following Atomic Design Theory
                   DESC
  s.homepage     = "https://github.com/design-ops/stylable-uikit"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.authors      = "atomoil", "deanWomborne", "kerrmarin", "jdbarbosa", "cristianoalves92"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/design-ops/stylable-uikit.git", :tag => "v#{s.version}" }

  s.frameworks   = [ 'Foundation', 'UIKit' ]
  s.swift_version = '5.0'
  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    # subspec for users who don't want to use Lottie
    core.source_files  = "StylableUIKit/", "StylableUIKit/Classes/**/*.swift"
    core.exclude_files = "StylableUIKit/Classes/Exclude", "StylableUIKit/Classes/Subspec"
  end

  s.subspec 'Lottie' do |lottie|
    lottie.dependency   'lottie-ios', '~> 3.1'
    lottie.dependency   'StylableUIKit/Core'
    lottie.source_files = "StylableUIKit/Classes/Subspec/Lottie"
    lottie.compiler_flags = "-DSTYLABLE_SUPPORTS_LOTTIE"
  end
end
