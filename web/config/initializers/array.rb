class Array
  def frequency
    p = Hash.new(0)
    each{ |v| p[v] += 1 }
    p
  end
end
