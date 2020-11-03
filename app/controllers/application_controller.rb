class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning, :success, :notice, :danger
end
