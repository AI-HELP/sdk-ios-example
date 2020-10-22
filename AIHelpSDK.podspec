Pod::Spec.new do |s|
  s.name              = "AIHelpSDK"
  s.version           = "2.1.0"
  s.summary           = "AIHelpSDK for iOS"
  s.homepage          = "https://github.com/AI-HELP/AIHelp-iOS-SDK"
  s.license      = { :type => "Apache-2.0", :file => "LICENSE" }
  s.author            = { "AIHelp" => "service_admin@aihelp.net" }
  s.platform          = :ios
  s.platform          = :ios, "9.0"
  s.requires_arc      = true

  s.source            = { :git => "https://github.com/AI-HELP/AIHelp-iOS-SDK.git", :tag => "#{s.version}" }

  s.resources    = 'AIHelp-iOS-SDK/AIHelpSDK/AIHelpSupportSDK.bundle'
  s.vendored_frameworks = 'AIHelp-iOS-SDK/AIHelpSDK/MQTTFramework.framework','AIHelp-iOS-SDK/AIHelpSDK/AIHelpSupportSDK.framework'
  s.frameworks = 'WebKit'
  s.library = 'sqlite3','resolv'
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

end
