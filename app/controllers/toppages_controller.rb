class ToppagesController < ApplicationController
  def index
    if logged_in?
      @boxpost = current_user.boxposts.build  # form_with 用
      @boxposts = current_user.boxposts.order(content: :asc)
    end
  end
end
