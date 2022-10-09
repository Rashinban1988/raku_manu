class Admin::ManualsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @manuals = Manual.all
    @manual = Manual.new
    @genres = Genre.all
    @genre = Genre.new
  end

  def new
    @manual = Manual.new
    @genres = Genre.all
  end

  def create
    @manual = Manual.new(manual_params)
    if @manual.save && @genre.sava
      redirect_to admin_manuals_path, notice: "マニュアルを投稿しました"
    else
      @manuals = Manual.all
      @genres = Genre.all
      flash[:alert] = "マニュアルの投稿に失敗しました"
      render :index
    end
  end

  def show
    @manual = Manual.find(params[:id])
    @comments = @manual.comments.all
  end

  def edit
    @manual = Manual.find(params[:id])
    @genres = Genre.all
  end

  def update
    @manual = Manual.find(params[:id])
    @genres = Genre.all
    if @manual.update(manual_params)
      redirect_to admin_manual_path(@manual), notice: "マニュアルを更新しました"
    else
      flash[:alert] = "マニュアルの更新に失敗しました"
      @manual = Manual.find(params[:id])
      render :edit
    end
  end

  def destroy
    @manual = Manual.find(params[:id])
    if @manual.destroy
      redirect_to admin_manuals_path, notice: "削除が完了しました"
    end
  end

  private

  def manual_params
    params.require(:manual).permit(:genre_name, :task_name, :description, :is_draft, :genre_id, :video, :re_draft)
  end

end
