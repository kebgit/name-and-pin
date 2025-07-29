class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.pin = SecureRandom.random_number(10**6).to_s.rjust(6, "0")

    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def login
  end

  def authenticate
    @user = User.find_by(name: params[:name], pin: params[:pin])

    if @user
      redirect_to user_path(@user)
    else
      flash[:alert] = "Invalid name or PIN"
      render :login
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
