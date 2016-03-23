class CategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :load_category, except: [:index, :new, :create]

  def index
   @categories = Category.page params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.success_created" 
      redirect_to categories_path      
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
      redirect_to [:admin, @category]
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
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description, :number_of_words_in_examination,
      words_attributes: [:id, :name, :_destroy, word_options_attributes:[:id,
      :content, :is_correct, :_destroy]]
  end
  
  def load_category
    @category = Category.find_by id: params[:id]
  end
end
