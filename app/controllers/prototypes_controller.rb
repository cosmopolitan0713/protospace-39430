class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy] 
  before_action :move_to_signin, except: [:index, :show] 
  before_action :authorize_user, only: [:edit, :update, :destroy]


  def index
    @prototypes =  Prototype.all
    @comment = Comment.new(user_id: current_user.id) if user_signed_in?
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
    redirect_to root_path
    else
    render  :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end
  
  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  
  def move_to_signin
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def authorize_user
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user == @prototype.user
      redirect_to root_path
    end
  end
  
end
