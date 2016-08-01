class StaticContactController < ApplicationController

  def index
      render params[:page]
  end

end
