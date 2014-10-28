require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yard"

RSpec::Core::RakeTask.new(:spec)

YARD::Rake::YardocTask.new do |t|
  t.files = Dir["lib/**/*.rb"]
end

desc "Run tests"
task default: [:spec]

desc "Document the Library"
task doc: [:yard]

desc "Bootstrap and copy the sample files for use" 
task(:bootstrap) do
  env_file = File.expand_path('../.env', __FILE__)
  if File.exists?(env_file)
    puts ".env exists, skipping..."
  else
    puts "Copying .env.sample to .env"
    env_sample = File.expand_path('../.env.sample', __FILE__)
    FileUtils.cp(env_sample, env_file)
  end

  ruby_version_file = File.expand_path('../.ruby-version', __FILE__)
  if File.exists?(ruby_version_file)
    puts ".ruby-version exists, skipping..."
  else
    puts "Copying .ruby-version.sample to .ruby-version"
    ruby_version_sample = File.expand_path('../.ruby-version.sample', __FILE__)
    FileUtils.cp(ruby_version_sample, ruby_version_file)
  end

  ruby_gemset_file = File.expand_path('../.ruby-gemset', __FILE__)
  if File.exists?(ruby_gemset_file)
    puts ".ruby-gemset exists, skipping..."
  else
    puts "Copying .ruby-gemset.sample to .ruby-gemset"
    ruby_gemset_sample = File.expand_path('../.ruby-gemset.sample', __FILE__)
    FileUtils.cp(ruby_gemset_sample, ruby_gemset_file)
  end
end
