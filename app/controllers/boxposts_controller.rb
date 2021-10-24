class BoxpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @boxpost = current_user.boxposts.build(boxpost_params)
    if @boxpost.save
      flash[:success] = "正常に投稿しました"
      redirect_to root_url
    else
      @boxposts = current_user.boxposts.order(id: :desc)
      flash[:danger] = "投稿に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @boxpost.destroy
    redirect_back(fallback_location: root_path)
    flash[:success] = "削除しました"
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
