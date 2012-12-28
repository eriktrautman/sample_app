class UsersController < ApplicationController
  
  # to require correctly authenticated users to do any of the major user actions
  before_filter :signed_in_user,  only: [:index, :edit, :update, :destroy, :followers, :following]
  before_filter :correct_user,    only:[:edit, :update]
  before_filter :admin_user,      only: :destroy

  def new
    if signed_in?
      redirect_to '/'
    else
  	   @user = User.new
    end
  end
  
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create
    if signed_in?
      redirect_to '/'
    else
    	@user = User.new(params[:user])
    	if @user.save
        sign_in @user
    		flash[:success] = "Welcome to my humble Sample App!"
    		redirect_to @user
    	else
    		render 'new'
    	end
    end
  end

  def destroy
    if User.find(params[:id]) == current_user
      redirect_to(root_path)
    else
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end

  def index
    # will display the list of all users (subject to authentication)
    @users = User.paginate(page: params[:page])
  end

  def edit
    # will display the "edit user" template for a given user ID if access is authorized (taken care of by the before_filter above)
  end

  def update
    # will take the submitted update PUT request and run it and go to the user page.  
    # If unsuccessful, rerender the edit page.
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user   # needed because the remember_token gets reset upon ANY new save!
      redirect_to @user 
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    # moved the signed_in_user to the SessionsHelper module

    # makes sure the user whose path we're trying to access (find) is the same as the current user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    # makes sure this user is actually an admin, otherwise it bounces him
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
