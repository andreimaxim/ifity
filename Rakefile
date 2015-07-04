require "bundler/gem_tasks"
require 'rake/testtask'
require 'rake/clean'

CLOBBER.include('**/*.gem')

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = "test/**/test_*.rb"
end

task :default => [:test]
