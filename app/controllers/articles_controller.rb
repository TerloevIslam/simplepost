class ArticlesController < ApplicationController
  before_action :set_and_authorize_article, only: %i[show edit update destroy]
  before_action :get_user, excepct: :index
  before_action :authenticate_user!, except: %i[index show]

  def index
    @articles = 
      if params[:user_id].present?
        User.find(params[:user_id]).articles
      else
        Article.all
      end
  end

  def show; end

  def new
    @article = @user.articles.new
  end

  def edit; end

  def create
    @article = @user.articles.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to root_path, notice: 'Article was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to root_path, notice: 'Article was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Article was successfully destroyed.' }
    end
  end

  private

  def get_user
    @user =
      if params[:action] == 'show'
        User.find(params[:user_id])
      else
        current_user
      end
  end

  def set_and_authorize_article
    @article = Article.friendly.find(params[:id])
    authorize @article
  end

  def article_params
    params.fetch(:article, {}).permit(:headline, :body, :user_id)
  end
end
