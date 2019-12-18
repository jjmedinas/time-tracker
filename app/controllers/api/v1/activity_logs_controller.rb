class Api::V1::ActivityLogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_admin!, only: [:report]
  before_action :authorize_employee!, except: [:report]
  before_action :set_user, except: [:report]
  before_action :set_activity_log, except: [:report]

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

  def report
    @users = User::Reducer.apply(params)
    begin
      report = AllUsersReport.new(@users.pluck(:id), start_date: report_start_date,
                                  end_date: report_end_date)

      render json: report.to_json, status: :ok
    rescue Exception => e

      render json: report.to_json, status: 400
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

    def report_start_date
      params.require(:start_date)
    end

    def report_end_date
      params.require(:end_date)
    end
end
