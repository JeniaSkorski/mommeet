class UsersController < ApplicationController
  #http_basic_authenticate_with :name => "123", :password => "123"
  
  skip_before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

   

  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    
    
    render json: @users if stale?(etag: @users.all, last_modified: @users.maximum(:updated_at))
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
   render json: @user if stale?(@user) 
  end

  # GET /users/new
  #def new
   # @user = User.new
    
  #end

  # GET /users/1/edit
 # def edit
  #end

  # POST /users
  # POST /users.json
  def create
     @user = User.new(user_params)

    if @contact.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #private

 


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
     @user.destroy

    head :no_content
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
