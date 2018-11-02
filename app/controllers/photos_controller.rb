class PhotosController < ApplicationController
  before_action :authenticate_user!

  before_action :set_photo, only: [:show, :edit, :update, :destroy, :toggle_like]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @comments = @photo.comments
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params) do |photo|
      photo.user = current_user
    end
    if @photo.save
      redirect_to root_path
    else
      redirect_to root_path, notice: @photo.errors.full_messages.first
    end
  end

  def toggle_like
    like = @photo.likes.where(user_id: params[:user_id])
    if like.present?
      like.first.destroy
      redirect_to photos_path
    else
      @photo.likes.create(user_id: params[:user_id])
      redirect_to photos_path
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:user_id, :avatar)
    end
end
