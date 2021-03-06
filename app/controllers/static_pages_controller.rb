class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @user = current_user
      @list = current_list
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end
end
