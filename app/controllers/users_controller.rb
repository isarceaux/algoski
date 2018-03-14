class UsersController < ApplicationController
	before_action :authenticate_user!
  # skip_before_action :verify_authenticity_token
  attr_accessor :current_ville_id

  def index
    @users = User.all
  end

  private

    def user_params
      params.require(:user).permit(:civility, :first_name, :last_name, :email, :password)
    end
  
end
