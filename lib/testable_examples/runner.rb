module TestableExamples
  class Runner
    def initialize(opts)
      @base = opts[:dir] || Dir.pwd
      @name = opts[:task_name] || "test_examples"
      @include_path = opts.key?(:include_path) ? opts[:include_path] : "lib"
      @requires = opts.key?(:requires) ? opts[:requires] : opts[:requires]
    end

    def install
      desc "Test your rdoc examples"
      task @name do
        run_examples
      end
    end

    def run_examples
      $: << @include_path if @include_path
      Array(@requires).each {|r| require r} if @requires
      in_example = false
      examples = []
      STDOUT.sync = true
      current_example = ''
      matchers = []
      rb_files = File.exist?(@base) ? [@base] : Dir[File.join(@base, 'lib/**/*.rb')]
      puts "Scanning #{rb_files * ', '}"
      rb_files.each do |file|
        lines = File.read(file).split(/\n/)
        lines.each do |line|
          if line[/^\s*#(.*)/] # comment
            line = $1.strip
            case line
            when /^example:/i then in_example = true
            when /^(?:# )?=+> (.*)/
              if in_example
                expected = $1.strip
                matchers << Matcher.new(expected)
                if matchers.last.match_exception?
                  current_example << " rescue e = $!; nil"
                end
                current_example << "\nmatchers[#{matchers.size - 1}].match(__example_runner, $!)"
              end
            when ''
              unless current_example.empty?
                examples << current_example
                current_example = ''
              end
              in_example = false
            else
              current_example << "\n__example_runner = (" << line << ")" if in_example
            end
          else
            unless current_example.empty?
              examples << current_example
              current_example = ''
            end
            in_example = false
          end
        end
      end
      print "Running #{examples.size} example#{'s' if examples.size != 1} "
      examples.each do |example|
        print "."
        eval(example)
      end
      puts " ✔"
      
    end
  end
end