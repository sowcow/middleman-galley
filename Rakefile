require 'bundler/gem_tasks'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format pretty'
end

task :default do
  if ENV['CI']
    require 'coveralls'
    Coveralls.wear!
  end
  Rake::Task[:features].invoke
end
#task default: :features
