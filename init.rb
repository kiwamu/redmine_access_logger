require 'redmine'
require 'application_controller_patch'

Redmine::Plugin.register :redmine_access_logger do
  name 'Redmine Access Logger plugin'
  author 'Kiwamu Kato'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

