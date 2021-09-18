class BoxpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @boxpost = current_user.boxposts.build(boxpost_params)
    if @boxpost.save
      flash[:success] = '数字を投稿しました。'
      redirect_to root_url
    else
      @boxposts = current_user.boxposts.order(id: :desc)
      flash.now[:danger] = '数字の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @boxpost.destroy
    flash[:success] = '数字を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def boxpost_params
    params.require(:boxpost).permit(:content)
  end
  
  def correct_user
    @boxpost = current_user.boxposts.find_by(id: params[:id])
    unless @boxpost
      redirect_to root_url
    end
  end
end
