class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    if session[:page_views]==nil
      article = Article.find(params[:id])
      session[:page_views] ||= 1
      render json: article
    elsif session[:page_views]<2
      article = Article.find(params[:id])
      session[:page_views] += 1
      render json: article
    else
      render json: { error: "Maximum pageview limit reached" }, status: :unauthorized
    end
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

end
