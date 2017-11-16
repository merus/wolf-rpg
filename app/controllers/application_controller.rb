class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  rescue_from Exception do |exception|
  	logger.fatal(params.to_s)
  	logger.fatal(exception.to_s)
  	raise exception
  end
end
