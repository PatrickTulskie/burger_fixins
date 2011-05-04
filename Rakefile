require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "burger_fixins"
    gem.summary = %Q{Simple gem for creating site-wide or application settings.}
    gem.description = %Q{Simple, yet, flexible redis-backed site/application settings manager.  Works with Rails, Sinatra, or just plain old Ruby.}
    gem.email = "patricktulskie@gmail.com"
    gem.homepage = "http://github.com/PatrickTulskie/burger_fixins"
    gem.authors = ["Patrick Tulskie"]
    gem.files.include 'burger_fixins.gemspec'
    gem.add_development_dependency "rspec", ">= 2.5.0"
    gem.add_dependency "redis", ">= 2.2.0"
    gem.add_dependency "redis-namespace", ">= 0.10.0"
    gem.add_dependency "redis-objects", ">= 0.5.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "burger_fixins #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
