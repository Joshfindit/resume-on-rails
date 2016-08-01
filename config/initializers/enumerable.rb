# From http://stackoverflow.com/questions/4689186/how-do-you-select-every-nth-item-in-an-array
module Enumerable
  def every_nth(n)
    (n - 1).step(self.size - 1, n).map { |i| self[i] }
  end
end 
