class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを追加しました"
    else
      @genres = Genre.all
      flash[:alert] = "ジャンル名を入力してください"
      render :index
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      # unless @genre.is_active
      #   @genre.manuals.update_all(is_active: false)
      # end
      redirect_to admin_genres_path, notice: "ジャンル名を更新しました"
    else
      flash[:alert] = "ジャンル名を入力してください"
      @genre = Genre.find(params[:id])
      render :edit
    end
  end

  def destroy
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
