class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @categories = Category.all
      @examination = Examination.new
      @feeds = current_user.feed.page params[:page]
    end
  end
end
