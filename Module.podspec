Pod::Spec.new do |spec|
  spec.name         = "Module"
  spec.version      = "0.0.1"
  spec.summary      = "This is summary of Module."
  spec.description  = "I have no idea what to write as a description"

  spec.homepage     = "https://github.com/nguyenduclong05112001/Module"
  spec.license      = "MIT"
  spec.author             = { "Teo" => "emma4real37@gmail.com" }
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/nguyenduclong05112001/Module.git", :tag => spec.version }
  spec.source_files  = "Module/**/*.{swift}"
  spec.swift_versions = "5.0"
end
