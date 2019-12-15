class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    if current_user.nil?
      return render json: { error: I18n.t("errors.requests.not_allowed")}, status: 403
    end
  end

  def authorize_admin!
    if current_user.try(:role) != User.roles[:admin]
      return render json: { error: I18n.t("errors.requests.not_allowed")}, status: 403
    end
  end

  def authorize_employee!
    if current_user.try(:role) != User.roles[:employee]
      return render json: { error: I18n.t("errors.requests.not_allowed")}, status: 403
    end
  end
end
