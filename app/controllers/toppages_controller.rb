class ToppagesController < ApplicationController
  def index
    if logged_in?
      @boxpost = current_user.boxposts.build
      @boxposts = current_user.boxposts.order(content: :asc)
      arry =current_user.boxposts.pluck(:content)
      sorted = arry.sort
      
      len = arry.length
      
      len == 0 ? lowest = 0 : lowest = arry.min
      len == 0 ? highest = 0 : highest = arry.max
      
      if len == 0
        median = 0
      elsif len % 2 == 0
        median = (sorted[len/2 - 1] + sorted[len/2]).to_f / 2
      else
        median = sorted[len/2]
      end
          
      q1_arry = sorted.slice(0, len/2)
      q1_len = q1_arry.length
      q1 = q1_len % 2 == 1 ? q1_arry[q1_len/2].to_i : (q1_arry[q1_len/2 - 1].to_i + q1_arry[q1_len/2].to_i).to_f / 2
      
      if len == 0
        q3_arry = []
      elsif len % 2 == 0
        q3_arry = sorted.slice(len/2 , len - 1)
      else
        q3_arry = sorted.slice(len/2 + 1, len - 1)
      end
      q3_len = q3_arry.length  
      q3 = q3_len % 2 == 1 ? q3_arry[q3_len/2].to_i : (q3_arry[q3_len/2 - 1].to_i + q3_arry[q3_len/2].to_i).to_f / 2
      
      category = ["データ"]
      current_quantity = [[lowest,q1,median,q3,highest]]
      
       @lowest = lowest
       @q1 = q1
       @median = median
       @q3 = q3
       @highest = highest
       
      @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '気温の箱ひげ図')
      f.xAxis(categories: category)
      f.series(name: '気温', data: current_quantity)
      f.chart(type: "boxplot" )
      end
    end
  end
end
