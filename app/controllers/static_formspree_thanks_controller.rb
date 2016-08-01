class StaticFormspreeThanksController < ApplicationController

  def index
      render params[:page]
  end

end
