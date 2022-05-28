class Admin::ManualsController < ApplicationController
  def index
    @manuals = Manual.all
  end

  def new
    @manual = Manual.new
    @genres = Genre.all
  end

  def create
    @manual = Manual.new(manual_params)
    if @manual.save
      redirect_to admin_manuals_path, notice: "マニュアルを投稿しました"
    else
      @manual = Manual.new
      flash[:alert] = "マニュアルの投稿に失敗しました"
      render :new
    end
  end

  def show
    @manual = Manual.find(params[:id])
  end

  def edit
    @manual = Manual.find(params[:id])
    @genres = Genre.all
  end

  def update
    @manual = Manual.find(params[:id])
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
    params.require(:manual).permit(:task_name, :description, :is_draft, :genre_id, :video, :re_draft)
  end

end
