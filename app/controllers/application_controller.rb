class ApplicationController < ActionController::Base
  prepend_view_path RelativeViewResolver.new("app/views") if Gem.win_platform?
end
