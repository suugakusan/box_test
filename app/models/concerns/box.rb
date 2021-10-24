module Box
  extend ActiveSupport::Concern
  
  def array_min
    @len == 0 ? @lowest = 0 : @lowest = @arry.min
  end
  
  def array_q1
    q1_arry = @sorted.slice(0, @len/2)
    q1_len = q1_arry.length
    @q1 = q1_len % 2 == 1 ? q1_arry[q1_len/2].to_i : (q1_arry[q1_len/2 - 1].to_i + q1_arry[q1_len/2].to_i).to_f / 2
  end
  
  def array_median
    if @len == 0
      return @median = 0
    elsif @len % 2 == 0
      return @median = (@sorted[@len/2 - 1] + @sorted[@len/2]).to_f / 2
    else
      return @median = @sorted[@len/2]
    end
  end
  
  def array_q3
    if @len == 0
      q3_arry = []
    elsif @len % 2 == 0
      q3_arry = @sorted.slice(@len/2 , @len - 1)
    else
      q3_arry = @sorted.slice(@len/2 + 1, @len - 1)
    end
    q3_len = q3_arry.length  
    @q3 = q3_len % 2 == 1 ? q3_arry[q3_len/2].to_i : (q3_arry[q3_len/2 - 1].to_i + q3_arry[q3_len/2].to_i).to_f / 2
  end
  
  def arry_max
    @len == 0 ? @highest = 0 : @highest = @arry.max
  end
end