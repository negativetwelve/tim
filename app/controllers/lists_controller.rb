class ListsController < ApplicationController
  
  def new
    @list = List.new
  end
  
  def create
    @list = List.new(params[:list])
    @list.user = current_user
    if @list.save
      flash[:success] = "Successfully created #{@list.name}!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  
end
