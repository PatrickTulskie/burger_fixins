# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{burger_fixins}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Patrick Tulskie"]
  s.date = %q{2011-05-05}
  s.description = %q{Simple, yet, flexible redis-backed site/application settings manager.  Works with Rails, Sinatra, or just plain old Ruby.}
  s.email = %q{patricktulskie@gmail.com}
  s.extra_rdoc_files = [
    "README.mdown"
  ]
  s.files = [
    ".document",
    "README.mdown",
    "Rakefile",
    "VERSION",
    "autotest/discover.rb",
    "burger_fixins.gemspec",
    "lib/burger_fixins.rb",
    "lib/burger_fixins/burger_fixins.rb",
    "spec/burger_fixins_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/PatrickTulskie/burger_fixins}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.3}
  s.summary = %q{Simple gem for creating site-wide or application settings.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.5.0"])
      s.add_runtime_dependency(%q<redis>, [">= 2.2.0"])
      s.add_runtime_dependency(%q<redis-namespace>, [">= 0.10.0"])
      s.add_runtime_dependency(%q<redis-objects>, [">= 0.5.0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.5.0"])
      s.add_dependency(%q<redis>, [">= 2.2.0"])
      s.add_dependency(%q<redis-namespace>, [">= 0.10.0"])
      s.add_dependency(%q<redis-objects>, [">= 0.5.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.5.0"])
    s.add_dependency(%q<redis>, [">= 2.2.0"])
    s.add_dependency(%q<redis-namespace>, [">= 0.10.0"])
    s.add_dependency(%q<redis-objects>, [">= 0.5.0"])
  end
end

