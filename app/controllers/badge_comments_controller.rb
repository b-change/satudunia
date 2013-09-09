class BadgeCommentsController < ApplicationController
  def index
    @badge_comments = BadgeComment.scoped
    @badge_comment = BadgeComment.new
  end

  def show
    @badge_comment = BadgeComment.find(params[:id])
  end


  def new
    @badge_comment = BadgeComment.new(:parent_id => params[:parent_id])
  end

  # def edit
  #   @badge_comment = BadgeComment.find(params[:id])
  # end

  def create
    @badge_comment = BadgeComment.new(params[:badge_comment])

    respond_to do |format|
      if @badge_comment.save
        format.html { redirect_to badges_path, notice: 'Badge comment was successfully created.' }
        format.json { render json: @badge_comment, status: :created, location: @badge_comment }
      else
        format.html { render action: "index" }
        format.json { render json: @badge_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @badge_comment = BadgeComment.find(params[:id])

    respond_to do |format|
      if @badge_comment.update_attributes(params[:badge_comment])
        format.html { redirect_to @badge_comment, notice: 'Badge comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @badge_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @badge_comment = BadgeComment.find(params[:id])
    @badge_comment.destroy

    respond_to do |format|
      format.html { redirect_to badge_comments_url }
      format.json { head :no_content }
    end
  end
end
