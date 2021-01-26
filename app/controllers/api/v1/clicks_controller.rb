class Api::V1::ClicksController < ApplicationController

  before_action :set_click
 
 def update
  begin 
    @click.amount_clicks = @click.amount_clicks.to_i + 1
    @click.save!
    
    render json: { data: 'ok' }, status: 201 
  rescue e
    render json: { error:  e.to_json }, status: 400
  end

 end 



 private 

 def click_params
  params.require(:clicks).permit(:path)
 end


 def set_click
  @click = Click.where(user_id: current_user.id, path: click_params[:path]).first_or_initialize
 end
end
