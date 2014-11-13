require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ["pkg/**/*.pp",
                                         "templates/**/*.*",
                                         "files/**/*.*",
                                         "spec/**/*.*",
                                         "vendor/**/*.*",
                                         "vagrant/**/*.pp"]

desc "Validate manifests, templates, and ruby files"
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb','lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/*/*_spec.rb'].exclude('spec/system/*_spec.rb')
end

RSpec::Core::RakeTask.new("spec:system") do |t|
  t.pattern = 'spec/system/*_spec.rb'
end

RSpec::Core::RakeTask.new("spec:all") do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

task :default => ["spec", "lint"]
