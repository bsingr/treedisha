# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{treedisha}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["dpree"]
  s.date = %q{2010-12-07}
  s.description = %q{Tiny file tree comparison library using sha1-checksums}
  s.email = %q{whiterabbit.init@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "lib/treedisha.rb",
    "lib/treedisha/comparator.rb",
    "lib/treedisha/filesystem.rb"
  ]
  s.homepage = %q{http://github.com/dpree/treedisha}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Tiny file tree comparison library}
  s.test_files = [
    "spec/lib/comparator_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/fixtures_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

