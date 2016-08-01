class StaticAboutController < ApplicationController

  def index
      render params[:page]
  end

end
