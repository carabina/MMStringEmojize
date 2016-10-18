Pod::Spec.new do |s|
  s.name = 'MMStringEmojize'
  s.version = '0.0.1'
  s.platform = :ios, '7.0'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.summary = 'A category on NSString to turn codes from Emoji Cheat Sheet into Unicode emoji characters.'
  s.homepage = 'https://github.com/xwgit2971/MMStringEmojize'
  s.author = { 'SunnyX' => '1031787148@qq.com' }
  s.source = { :git => 'https://github.com/xwgit2971/MMStringEmojize.git', :tag => s.version }
  s.source_files = 'MMStringEmojize/*.{h,m}'
  s.framework = 'Foundation'
  s.requires_arc = true
end
