module Enumerable
  def my_each
    length = self.length
    length.times do |n|
      yield(self[n])
    end
    self
  end

  def my_each_with_index
    length = self.length
    length.times do |n|
      yield(self[n], n)
    end
  end

  def my_select
    result = []
    my_each do |i|
      result << i if yield(i)
    end
    result
  end

  def my_all?
    if block_given?
      result = []
      my_each do |i|
        result << i if yield(i)
      end
      result == self ? true : false
    else # If no block is given
      my_each { |i| return false if i == false || i.nil? }
      true
    end
  end

  def my_any?
    if block_given?
      my_each { |i| return true if yield(i) }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |i| return false if yield(i) }
    else
      my_each { |i| return false if i }
    end
    true
  end

  def my_count(item = nil)
    if block_given?
      result = []
      my_each { |i| result << i if yield(i) }
      return result.length
    end
    if item
      result = []
      my_each { |i| result << i if i == item }
      return result.length
    end
    return length if item.nil?
  end

  def my_map(p = nil)
    result = []
    if block_given?
      my_each do |i|
        result << yield(i)
      end
    elsif p
      my_each do |i|
        result << p.call(i)
      end
    end
    result
  end

  def my_inject(result = nil)
    my_each do |n|
      result = result ? yield(result, n) : self[0]
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |r, i| r * i }
end
