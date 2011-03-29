require 'testable_examples/matcher'
require 'testable_examples/runner'

module TestableExamples
  def self.install_tasks(opts = {})
    Runner.new(opts).install
  end
end
