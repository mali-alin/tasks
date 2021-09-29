class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was sucessfully updated'
    else
      render :edit
    end
  end

  def destroy

  end

  private

  def set_current_user
    @user =  current_user
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
