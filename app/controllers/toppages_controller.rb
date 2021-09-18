class ToppagesController < ApplicationController
  def index
    if logged_in?
      @boxpost = current_user.boxposts.build
      @boxposts = current_user.boxposts.order(content: :asc)
      arry =current_user.boxposts.map {|hash| hash[:content].to_i}
      sorted = arry.sort
      
      if current_user.boxposts.any?
      lowest = arry.min
      highest = arry.max
      len = arry.length
      median = len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2
      if len % 4 == 0
        q1 = (sorted[len/4 - 1] + sorted[len/4]).to_f / 2
      elsif len % 4 == 1
        q1 = (sorted[len/4 - 1] + sorted[len/4]).to_f / 2
      elsif len % 4 == 2
        q1 = sorted[len/4]
      elsif len % 4 == 3
        q1 = sorted[len/4]
      end

      if len % 4 == 0
        q3 = (sorted[len*3/4 - 1] + sorted[len*3/4]).to_f / 2
      elsif len % 4 == 1
        q3 = (sorted[len*3/4] + sorted[len*3/4 + 1]).to_f / 2
      elsif len % 4 == 2
        q3 = sorted[len*3/4]
      elsif len % 4 == 3
        q3 = sorted[len*3/4]
      end
      end
      category = ["データ"]
      current_quantity = [[lowest,q1,median,q3,highest]]

      @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '気温の箱ひげ図')
      f.xAxis(categories: category)
      f.series(name: '気温', data: current_quantity)
      f.chart(type: "boxplot" )
      end
      
    end
    
  end
end
