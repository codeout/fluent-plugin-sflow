require "bundler/gem_tasks"
require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new("sflowtool") do |ext|
  ext.lib_dir = "lib/sflowtool"
end

task :default => [:clobber, :compile]
