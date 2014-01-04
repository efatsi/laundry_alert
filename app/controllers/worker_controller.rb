class WorkerController < ApplicationController

  def go
    LaundryAlert::Worker.do_work

    render :nothing => true
  end

end
