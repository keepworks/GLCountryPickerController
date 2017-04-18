Pod::Spec.new do |s|
  s.name         = "EMCCountryPickerController+DialingCodes"
  s.version      = "1.4.1"
  s.summary      = "EMCCountryPickerController+Dialing is allows users to choose and filter countries in a list. Provides flags, dialing codes and country codes"
  s.description  = <<-DESC
                   `EMCCountryPickerController` is a view controller that allow users to choose
                   a country from a searchable list.  The available countries are taken from the
                   [ISO 3166-1 standard][iso3166], whose [ISO 3166-1 alpha-2] two-letter country
                   codes are used internally by the controller implementation.  Public domain
                   flags are available for every country, and corresponding dialing codes are also available
                   DESC
  s.homepage     = "https://github.com/AmilaDiman/EMCCountryPickerController-DialingCodes"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author             = { "Amila Dimantha" => "http://thegreyblog.blogspot.com/" }
  s.social_media_url   = ""
  s.platform     = :ios, "6.1"
  s.source       = { :git => "https://github.com/AmilaDiman/EMCCountryPickerController-DialingCodes.git", :tag => "1.4.1" }
  s.source_files  = "EMCCountryPickerController", "EMCCountryPickerController/**/*.{h,m}"
  s.exclude_files = "EMCCountryPickerController/Exclude"
  s.resources = "EMCCountryPickerController/EMCCountryPickerController.bundle"
  s.requires_arc = true
end
