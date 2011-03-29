class Test1
  
  # Example:
  #   Test1.new.add(1, 2)
  #   => 3
  #   Test1.new.add(1, "something")
  #   => TypeError: String can't be coerced into Fixnum
  def add(num1, num2)
    num1 + num2
  end
end