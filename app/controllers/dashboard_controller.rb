class DashboardController < ApplicationController
  before_action :authorize!, except: :login

  def login
  end

  def index
  end
end
