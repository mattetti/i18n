Gem::Specification.new do |s|
  s.name = "i18n"
  s.version = "0.1.0"
  s.date = "2008-06-13"
  s.summary = "Internationalization for Ruby"
  s.email = "rails-patch-i18n@googlegroups.com"
  s.homepage = "http://groups.google.com/group/rails-patch-i18n"
  s.description = "Add Internationalization to your Ruby application."
  s.has_rdoc = false
  s.authors = ['Sven Fuchs', 'Matt Aimonetti', 'Stephan Soller', 'Saimon Moore']
  s.files = [
    "lib/i18n/backend/simple.rb",
    "lib/i18n/exceptions.rb",
    "lib/i18n.rb",
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