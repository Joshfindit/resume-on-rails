class Float
  def floor2_s(n=0)
    int,dec=self.to_s.split('.')
    # puts "self: #{self}"
    if n == 0
      # puts "#{int}"
      "#{int}"
    else
      # puts "#{int}.#{dec[0..n-1]}"
      "#{int}.#{dec[0..n-1]}"
    end
  end
end
