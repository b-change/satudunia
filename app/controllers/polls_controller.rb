class PollsController < ApplicationController
   layout "experiment"
  def index
    add_breadcrumb "Polls", polls_path.gsub("/","")
    set_page_title("Polls")
    @polls = Poll.where(:is_active => true).page(params[:page])
  end

  def show
    @poll = Poll.by_slug(params[:id])
  end

  def create
    @poll = Poll.find(params[:id])

    if @poll.present?
      message = @poll.take_action(current_user, params['poll_option'])
      if message.blank?
        flash[:notice] = "Thank you for participating"
        redirect_to poll_path(@poll.slug)
      else
        flash[:error] = message
        redirect_to poll_path(@poll.slug)
      end
    else
      flash[:error] = "Poll not found"
      redirect_to poll_path(@poll.slug)
    end
  end
end