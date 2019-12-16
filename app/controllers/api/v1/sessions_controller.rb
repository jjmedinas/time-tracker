class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by email: session_params[:email]

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id

      render json: user, status: :ok
    else
      render json: { error: I18n.t("errors.requests.bad_login") }, status: 401
    end
  end

  def destroy
    session.delete(:user_id)
    return head :no_content
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
