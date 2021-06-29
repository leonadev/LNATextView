Pod::Spec.new do |s|
  s.name         = 'LNATextView'
  s.version      = '1.0.1'
  s.summary      = 'An iOS textview which supports placeholder.'
  s.homepage     = 'https://github.com/leonadev/LNATextView.git'
  s.license      = 'MIT'
  s.author       = { 'leonadev' => 'leonadev@163.com' }
  s.platform     = :ios, '9.0'
  s.source       = { :git => 'https://github.com/leonadev/LNATextView.git', :tag => s.version }
  s.source_files = 'LNATextView/**/*.{h,m}'
  s.requires_arc = true
end