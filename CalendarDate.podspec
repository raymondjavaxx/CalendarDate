Pod::Spec.new do |s|
  s.name         = "CalendarDate"
  s.version      = "1.1.1"
  s.summary      = "Calendar dates for Swift."
  s.homepage     = "https://github.com/raymondjavaxx/CalendarDate"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Ramon Torres" => "raymondjavaxx@gmail.com" }
  s.social_media_url = "https://twitter.com/ramontorres"

  s.ios.deployment_target  = "13.0"
  s.osx.deployment_target  = "10.15"
  s.tvos.deployment_target = "13.0"

  s.swift_version = "5.1"

  s.source       = { :git => "https://github.com/raymondjavaxx/CalendarDate.git", :tag => "#{s.version}" }
  s.source_files = "Sources/CalendarDate/*.swift"
end
