class UsersController < ApplicationController
  def index

    @users = User.all 
  end
  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path

  end

  def leaderboards
    @scores = Merit::Score.top_scored
    # @friends = friends_leaderboards(current_user)
    @friends = current_user.followings
    @friends_scores = friends_leaderboards(current_user).sort_by { |k, v| k[:sum_points]}.reverse
  end


  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  

  def friends_leaderboards(user)
    leaderboard = []
    user.followings.each do |friend| 
      leaderboard << {:user_id => friend.id, :sum_points => friend.points }
    end
    return leaderboard

  end



end
