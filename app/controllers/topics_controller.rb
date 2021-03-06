class TopicsController < ApplicationController
  def index
    @topics = Topic.paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic    
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic    
  end

 
  def create
    @topic = Topic.new(params.require(:topic).permit(:name, :description, :public))
    # @post = current_user.posts.build(post_params) # Will this go here but use @topic var?
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    # @post = current_user.posts.build(post_params) # Will this go here but use @topic var?
    authorize @topic
    if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again"
      render :edit
    end
  end
  
  # Discuss with Xander syntax for Stage - 35 Interlude, assignment for commented area below using "topic_param" method
  # private

  #def post_params # will this be "def topics_param" ?  What about the rest?
  #  params.require(:post).permit(:title, :body)
  #end
  
end
