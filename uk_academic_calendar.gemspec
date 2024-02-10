# frozen_string_literal: true

require_relative 'lib/uk_academic_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = 'uk_academic_calendar'
  spec.version       = UKAcademicCalendar::VERSION
  spec.authors       = ['Matt']
  spec.email         = ['jetnova@pm.me']

  spec.summary       = "Making the UK's Academic Year (Sept 1st -> Aug 31st) easier to work with."
  spec.description   = 'Provides Term objects and extensions to Date/Time classes'
  spec.homepage      = "https://www.github.com/m-smiff/#{spec.name}"
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['documentation_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'abstract_class', '~> 1.0'
  spec.add_dependency 'activesupport', '~> 6.1'
  spec.add_dependency 'easter', '~> 0.2'
  spec.add_dependency 'sorted_set', '~> 1.0'
end
