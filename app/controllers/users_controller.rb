class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update destroy]

  def index
    authorize current_user

    @users = policy_scope(User).kept

    render json: @users
  end

  def show
    authorize @user

    render json: @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user

    @user.discard
  end

  private

    def set_user
      @user = policy_scope(User).find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
