class Api::V1::ActivityLogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_employee!
  before_action :set_user
  before_action :set_activity_log

  def current
    return render json: @activity_log, status: :ok
  end

  def check_in
    begin
      @activity_log.check_in!

      return render json: @activity_log, status: :ok
    rescue => e

      return render json: { errors: e.record.errors}, status: 400
    end
  end

  def check_out
    begin
      @activity_log.check_out!

      return render json: @activity_log, status: :ok
    rescue => e

      return render json: { errors: e.record.errors}, status: 400
    end
  end

  private
    def set_user
      @user = User.find_by id: params[:user_id]

      if @user.nil?
        return render json: { error: I18n.t("errors.requests.not_allowed") }, status: 400
      end
    end

    def set_activity_log
      @activity_log = @user.activity_log
    end
end
