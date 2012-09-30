class CommandController < ApplicationController
  
  def parse
    @command = Command.new
    @list = current_list
    @command.oneline(params[:command]["input"].to_s, @list, current_user)
    redirect_to root_path
  end
  
end