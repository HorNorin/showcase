class RegistrationsController < Devise::RegistrationsController
  before_action :rediect_user_signed_in_with_omniauth, only: [:edit, :update]
  
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end
  
  private
  
  def rediect_user_signed_in_with_omniauth
    if signed_in_with_omniauth?
      flash[:error] = "You can't edit your profile when signed in using third party websit."
      redirect_to root_path
    end
  end
end
