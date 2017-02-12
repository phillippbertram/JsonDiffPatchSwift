Pod::Spec.new do |s|
  s.name = 'JsonDiffPatchSwift'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'Simple jsondiffpatch wrapper for Swift'
  s.homepage = 'https://github.com/phillippbertram/JsonDiffPatchSwift'
  s.authors = { 'Phillipp Bertram' => 'phillipp.bertram@gmail.com' }
  s.source = { :git => 'https://github.com/phillippbertram/JsonDiffPatchSwift.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/*.swift'
end