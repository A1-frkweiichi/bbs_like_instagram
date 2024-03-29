class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:create, :update]

  # GET /posts or /posts.json
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:tags, :user)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params.except(:tags))
    tags_str = post_params[:tags]
    tags = tags_str.split(',').map(&:strip)
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @post.tags << tag
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    updated_params = post_params.except(:tags)
    tags_str = post_params[:tags]
    tags = tags_str.split(',').map(&:strip)
    @post.tags.clear
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @post.tags << tag
    end

    respond_to do |format|
      if @post.update(updated_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :image, :tags)
    end
end
