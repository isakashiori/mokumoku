# frozen_string_literal: true

class Mypage::ProfilesController < Mypage::BaseController
  def show
    if params[:user_id] == nil
      @user = current_user
    else
      @user = User.find(params[:user_id])
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(profile_params)
      redirect_to mypage_profile_path, success: 'プロフィールを更新しました'
    else
      render :show
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :avatar, :email, :profile, :hobby)
  end
end
