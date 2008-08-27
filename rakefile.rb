require 'rubygems'
require "rake"
require "rake/clean"
require "rake/gempackagetask"

##############################################################################
# Package && release
##############################################################################
RUBY_FORGE_PROJECT  = "i18n"
PROJECT_URL         = "http://groups.google.com/group/rails-patch-i18n"
PROJECT_SUMMARY     = "Internationalization for Ruby"
PROJECT_DESCRIPTION = "Add Internationalization to your Ruby application."

AUTHOR = ['Sven Fuchs', 'Matt Aimonetti', 'Stephan Soller', 'Saimon Moore']
EMAIL  = "rails-patch-i18n@googlegroups.com"

GEM_NAME    = "i18n"
PKG_BUILD   = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
GEM_VERSION = "0.1.0"

RELEASE_NAME    = "REL #{GEM_VERSION}"

spec = Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.date = "2008-06-13"
  s.summary = PROJECT_SUMMARY
  s.email = EMAIL
  s.homepage = PROJECT_URL
  s.description = PROJECT_DESCRIPTION
  s.has_rdoc = false
  s.authors = AUTHOR
  s.files = [
    "lib/i18n/backend/simple.rb",
    "lib/i18n/exceptions.rb",
    "lib/i18n.rb",
    "rakefile.rb",
    "MIT-LICENSE",
    "README.textile",
    "test/all.rb",
    "test/i18n_exceptions_test.rb",
    "test/i18n_test.rb",
    "test/locale/en-US.rb",
    "test/locale/en-US.yml",
    "test/simple_backend_test.rb"
  ]
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
end

desc "Publish the release files to RubyForge."
task :release => [ :package ] do
  packages = %w( gem tgz zip ).collect{ |ext| "pkg/#{GEM_NAME}-#{GEM_VERSION}.#{ext}" }

  begin
    sh %{rubyforge login}
    sh %{rubyforge add_release #{RUBY_FORGE_PROJECT} #{GEM_NAME} #{GEM_VERSION} #{packages.join(' ')}}
    sh %{rubyforge add_file #{RUBY_FORGE_PROJECT} #{GEM_NAME} #{GEM_VERSION} #{packages.join(' ')}}
  rescue Exception => e
    puts
    puts "Release failed: #{e.message}"
  end
end