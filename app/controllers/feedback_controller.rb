class FeedbackController < ApplicationController
	

  def create
  
  	@feedback= Feedback.create(params[:feedback])
    if @feedback.save
      redirect_to root_path
      flash[:notice] = "Thank you,for your feedback"
     else
      redirect_to rootx_path
      flash[:alert]= "Something Went Wrong"
      #flash[:alert] = "Thank you, your registration is now completed. You have registered on 19-11-2013. You will receive SMS or email reminders every: 6 Months."
    end
  end	
end
