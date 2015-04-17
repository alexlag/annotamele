class Foo
  def self.block(&block)
    @@block = block
  end

  def test(a)
    instance_exec a, &@@block
  end
end

class Bar < Foo
  block do |x|
    x + x
  end
end

class Test
  def initialize
    @bar = Bar.new
    @a = 2
  end

  def test
    @a = @bar.test(8)
  end

  def print
    puts @a
  end
end

b = Test.new
b.print
b.test
b.print
