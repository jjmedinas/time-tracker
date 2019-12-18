class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/users
  # GET /api/v1/users.json
  def index
    @users = User::Reducer.apply(params)

    render json: @users, status: :ok
  end

  # GET /api/v1/users/1
  # GET /api/v1/users/1.json
  def show
    return render json: @user, status: :ok
  end

  # POST /api/v1/users
  # POST /api/v1/users.json
  def create
    @user = User.new(user_params)

    if @user.save
      return render json: { user: @user }, status: :created
    else
      return render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  # PATCH/PUT /api/v1/users/1.json
  def update
    if @user.update(user_params)
      return render json: { user: @user }, status: :ok
    else
      return render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  # DELETE /api/v1/users/1.json
  def destroy
    @user.destroy
    return head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])

      return render json: { error: ActiveRecord::RecordNotFound.new }, status: :not_found unless @user.present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :first_name, :last_name, :email, :gender, :role,
                                   :password, :password_confirmation)
    end
end
