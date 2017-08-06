require "bundler/gem_tasks"
require "rake/extensiontask"
require "rake/testtask"

task :build => :compile

Rake::ExtensionTask.new("sflowtool") do |ext|
  ext.lib_dir = "lib/sflowtool"
end

Rake::TestTask.new do |t|
  t.verbose = true
end

task :default => [:clobber, :compile]
