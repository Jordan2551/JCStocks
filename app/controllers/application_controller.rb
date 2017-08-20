class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Before any action by this controller is executed, we MUST have a logged in user.
  before_action :authenticate_user!


end
