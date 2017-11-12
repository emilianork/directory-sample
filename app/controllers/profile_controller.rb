class ProfileController < ApplicationController

  # PUT /profile
  def update
    if current_user.update(profile_params)
      render json: current_user.profile_json, status: 200
    else
      render_error
    end
  end

  def profile_params
    params.permit(:first_name, :last_name)
  end
end
