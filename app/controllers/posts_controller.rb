class PostsController < ApplicationController
  before_action :check_social_network
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :store_latest_url, only: [:create, :edit, :update]


  def create
  end

  def destroy
  end

  # GET /posts
  # GET /posts.json
  def index
    notice "Posts.index"
  #  @users = User.as(:t).where('true = true WITH t ORDER BY t.first_name, t.last_name desc')
    @posts = Post.all.order(created_at:  :desc)
  end

  def self.find user
    notice "Posts.self.find user"
    @posts = Post.as(:u).all.is_owned_by.match_to(user).order(u.created_at:  :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show user
    notice "Posts.show user"
    @posts = Post.as(:u).all.is_owned_by.match_to(user).order(u.created_at:  :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @user = current_user
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    #@post = Post.new(post_params, is_owned_by: current_user)
    @post = Post.new(post_params)
     puts "session[:latest_url] in post.create: #{session[:latest_url]} §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§"
    respond_to do |format|
      if @post.save
         rel = Owns.create(from_node: current_user, to_node: @post)
  
        format.html { redirect_to session[:latest_url], notice = 'Post was successfully created.' }
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post, user: @post.is_owned_by }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_current_user
     current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :title, :is_owned_by, :user)
    end
end
