class ToppagesController < ApplicationController
  include Box
  def index
    if logged_in?
      @boxpost = current_user.boxposts.build
      @boxposts = current_user.boxposts.order(content: :asc)
      @arry =current_user.boxposts.pluck(:content)
      @sorted = @arry.sort
      @len = @arry.length
      
      array_min #最小値を求めるメソッド(@lowestを定義)
      array_q1 #第1四分位数を求めるメソッド(@q1を定義)
      array_median #中央値を求めるメソッド(@medianを定義)
      array_q3 #第3四分位数を求めるメソッド(@q3を定義)
      arry_max #最大値を求めるメソッド(@highestを定義)
       
      category = ["データ"]
      current_quantity = [[@lowest,@q1,@median,@q3,@highest]]
      
       
      @graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '気温の箱ひげ図')
      f.xAxis(categories: category)
      f.series(name: '気温', data: current_quantity)
      f.chart(type: "boxplot" )
      end
    end
  end
end
