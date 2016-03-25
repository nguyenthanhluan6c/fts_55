class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @categories = @categories.page params[:page]
  end

  def new
  end

  def create
    if @category.save
      flash[:success] = t "category.success_created" 
      redirect_to admin_categories_path      
    else
      render :new
    end
  end

  def show
    @questions = @category.questions
  end

  def edit
  end

  def update
    if @category.update_attributes category_params      
      flash[:success] = t "category.updated"
      redirect_to admin_categories_path
    else
      @category.reload
      render :edit
    end
  end

  def destroy 
    if @category.destroy      
      flash[:success] = t "category.deleted"      
    else
      flash[:danger] = t "category.can_not_delete"     
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description, :number_of_questions_in_examination,
      questions_attributes: [:id, :name, :_destroy]
  end
end
