# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    events_path
  end
end
