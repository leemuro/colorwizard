require 'lib/colorwizard'

class HomeController < ApplicationController
  def index
  end

  def color
    @color = ColorWizard.color_of(params[:q])
  end
end
