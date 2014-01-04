class RunsController < ApplicationController
  def show
    @run = Run.find(params[:id])
    render :show, :layout => false
  end
end
