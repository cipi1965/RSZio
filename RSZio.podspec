Pod::Spec.new do |spec|
  spec.name = "RSZio"
  spec.version = "1.0.0"
  spec.summary = "Wrapper for rsz.io apis."
  spec.homepage = "https://github.com/cipi1965/RSZio"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Matteo Piccina" => 'altermatte@gmail.com' }
  spec.social_media_url = "http://twitter.com/cipi1965"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/cipi1965/RSZio.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "RSZio/**/*.{h,swift}"

  spec.dependency "Alamofire", "~> 3.4"
end
