# Testable Examples

Run your rdoc examples like they are tests!

## How to

In your rdoc, you might have something like this

    # Example:
    #   Test1.new.add(1, 2)
    #   => 3
    #   Test1.new.add(1, "something")
    #   => TypeError: String can't be coerced into Fixnum
    def add(num1, num2)
      num1 + num2
    end

With testable examples, simply add this to your Rakefile

    desc "test_examples"
    task :test do
      $: << 'lib'
      require 'testable_examples'
      TestableExamples::Runner.new(:dir => 'lib', :include_path => 'lib', :requires => 'test1').run_examples
    end

And you will now be able to validate these!

## TODO

So much, this is really just a proof-of-concept.
