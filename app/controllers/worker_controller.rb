class WorkerController < ApplicationController

  def go
    LaundryAlert::Worker.check

    render :nothing => true
  end

end
