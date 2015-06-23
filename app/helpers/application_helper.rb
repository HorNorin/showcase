module ApplicationHelper
  def signed_in_with_omniauth?
    current_user.uid || current_user.provider
  end
end
