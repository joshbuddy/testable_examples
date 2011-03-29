module TestableExamples
  class Matcher
    def initialize(val)
      @val = val
      @literal_val = begin
        eval(val)
      rescue Exception
        nil
      end
    end

    def match(*args)
      o = args.compact.first
      if @literal_val
        @literal_val === o
      elsif @val[/^[A-Z][a-z0-9_]*$/]
        Object.const_get(@val.to_sym)
      elsif @val[/^([A-Z][a-zA-Z0-9_]*?):(.*)$/] and o.is_a?(Exception)
        o.class.to_s === $1.strip && o.message == $2.strip
      else
        raise "Unable to understand val type #{@val.inspect}"
      end
    end

    def match_exception?
      @val[/^[A-Z]/]
    end

    def assert(*args)
      match(*args) or raise("Unable to match #{args.inspect} against #{@val.inspect}")
    end
  end
end