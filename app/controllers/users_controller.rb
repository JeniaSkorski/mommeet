class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

   

    def signup
    if params[:fb_uid].present?
      if params[:anonymous_id].present?
        @user = User.find(params[:anonymous_id])
        @user.fb_uid = params[:fb_uid]
      else
        @user = User.find_or_initialize_by_fb_uid(params[:fb_uid])
      end
      @user.fb_access_token = params[:fb_access_token]
      @user.image = "http://graph.facebook.com/#{params[:fb_uid]}/picture?width=100&height=100"
      @user.name = params[:name] || "Facebook User"
     
    else
      @user = User.new
    end
    render json: { success: @user.save!, user_id: @user.id, errors: @user.errors }
  end


  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

 


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
       format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :unique_id, :name, :about)
    end
end
