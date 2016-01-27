module ApplicationHelper
  def user_account
    current_user.account
  end

  def user_has_account?
    current_user.has_account?
  end
end
