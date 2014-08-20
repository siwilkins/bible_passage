Gem::Specification.new do |s|
  s.name        = 'bible_passage'
  s.summary     = 'A simple library for parsing and rendering bible passages'
  s.version     = '0.2.1'
  s.authors     = ["Si Wilkins"]
  s.email       = 'si.wilkins@gmail.com'
  s.homepage    = 'https://github.com/siwilkins/bible_passage'
  readmes       = Dir['*'].reject{ |x| x = ~ /(^|[^.a-z])[a-z]+/ || x == "TODO" || x =~ /\.gem$/ }
  s.files       = Dir['lib/**/*', 'spec/**/*'] + readmes
  s.has_rdoc    = false
  s.test_files  = Dir["test/**/*_test.rb"]
  s.license     = "MIT"
  s.description = <<-END
bible_passage provides a facility for parsing a string to check its validity
as a Bible reference, and then render it in a consistent manner.
END
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'guard', '~> 2.6'
  s.add_development_dependency 'guard-rspec', '~> 4.2'
  s.add_development_dependency 'fuubar', '~> 1.3'
end
