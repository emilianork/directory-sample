class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!

  def render_error
    render json: { message: 'Something when wrong' }, status: 500
  end
end
