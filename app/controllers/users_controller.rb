class UsersController < ApplicationController

  def show
      @user = User.find(params[:id])
      @title = @user.nom
  end


  def new
      @user = User.new
      @title = "Inscription"
  end

  def create
    #@user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple !"
      redirect_to @user
    else
      @title = "Inscription"
      render 'new'
    end
  end


  private

    def user_params
      params.require(:user).permit(:nom, :email, :password,
                                   :password_confirmation)
#      params.require(:user).permit(:nom, :email, :password,
#              :password_confirmation, :date_of_birth, :attachment,
#              :films_per_week, :more_books)
    end

end
