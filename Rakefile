require 'bundler'
Bundler::GemHelper.install_tasks

desc "test"
task :test do
  $: << 'lib'
  require 'testable_examples'
  TestableExamples::Runner.new(:dir => 'test/test1.rb', :include_path => 'test', :requires => 'test1').run_examples
end