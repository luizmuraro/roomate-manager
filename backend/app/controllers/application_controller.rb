class ApplicationController < ActionController::API
  # Skip CSRF token for API
  skip_before_action :verify_authenticity_token, raise: false

  # For now, let's disable authentication to test the API
  private

  def authenticate_user!
    # TODO: Implement JWT authentication
    true
  end

  def current_user
    # For testing purposes, return the first user
    @current_user ||= User.first
  end
end
