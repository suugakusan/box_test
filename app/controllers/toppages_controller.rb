class ToppagesController < ApplicationController
  def index
    if logged_in?
      @boxpost = current_user.boxposts.build
      @boxposts = current_user.boxposts.order(content: :asc)
      
      category = ["データ"]
      current_quantity = [@boxposts.pluck(:content)]

      @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '気温の箱ひげ図')
      f.xAxis(categories: category)
      f.series(name: '気温', data: current_quantity)
      f.chart(type: "boxplot" )
      end
      
    end
    
  end
end
