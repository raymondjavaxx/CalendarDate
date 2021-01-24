Pod::Spec.new do |s|
  s.name         = "CalendarDate"
  s.version      = "1.0.1"
  s.summary      = "Calendar dates for Swift."
  s.homepage     = "https://github.com/raymondjavaxx/CalendarDate"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Ramon Torres" => "raymondjavaxx@gmail.com" }
  s.social_media_url = "https://twitter.com/ramontorres"

  s.ios.deployment_target  = "11.0"
  s.osx.deployment_target  = "10.9"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/raymondjavaxx/CalendarDate.git", :tag => "#{s.version}" }
  s.source_files = "Sources/CalendarDate/*.swift"
end
