Gem::Specification.new do |gem|
  gem.name    = 'sj-ignore'
  gem.version = '0.0.1'
  gem.date    = Date.today.to_s
  gem.executables << 'sj-ignore'

  gem.summary = "Easy command line utility to create a multi-faceted .gitignore file"
  gem.description = "sj-ignore uses github's gitignore repository to make it easy to list all the languages and platforms you would like included in your .gitignore file"

  gem.authors  = ['Shane Gianelli']
  gem.email    = 'shane@gianel.li'
  gem.homepage = 'http://github.com/sjdev/sj-ignore'

  gem.add_dependency('github_api')

  #gem.files = ["bin/sj-ignore.rb"]
end
