Gem::Specification.new do |s|
  s.name = "procer"
  s.summary = "Provides a reasonable good default `to_proc` method to all objects"
  s.description = File.read(File.join(File.dirname(__FILE__), 'README.md'))
  s.version = '0.1'
  s.authors = ["Jesús Gómez"]
  s.email = "jgomo3@gmail.com"
  s.homepage = "https://github.com/jgomo3/procer/"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.8.7'
  s.files = ['lib/procer.rb']
  #s.test_files = Dir['test/test*.rb']
  s.license = "MIT"
end
