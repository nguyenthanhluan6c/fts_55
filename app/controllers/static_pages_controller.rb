class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @categories = Category.all
      @examination = Examination.new
    end
  end
end
