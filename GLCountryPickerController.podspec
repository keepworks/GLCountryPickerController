Pod::Spec.new do |s|
  s.name         = "GLCountryPickerController"
  s.version      = "1.5.0"
  s.summary      = "GLCountryPickerController is allows users to choose and filter countries in a list. Provides flags, dialing codes and country codes"
  s.description  = <<-DESC
                   `GLCountryPickerController` is a view controller that allow users to choose
                   a country from a searchable list.  The available countries are taken from the
                   [ISO 3166-1 standard][iso3166], whose [ISO 3166-1 alpha-2] two-letter country
                   codes are used internally by the controller implementation.  Public domain
                   flags are available for every country, and corresponding dialing codes are also available
                   DESC
  s.homepage     = "https://github.com/ghostlordstar/GLCountryPickerController"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author             = { "ghostlordstar" => "https://ghostlordstar.github.io" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ghostlordstar/GLCountryPickerController.git", :tag => "1.5.0" }
  s.source_files  = "GLCountryPickerController", "GLCountryPickerController/**/*.{h,m}"
  s.exclude_files = "GLCountryPickerController/Exclude"
  s.resources = "GLCountryPickerController/GLCountryPickerController.bundle"
  s.requires_arc = true
end
