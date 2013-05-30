class Experimental::ExperimentalController < ApplicationController
	layout 'experiment'
  def index

  end
  # action public about
  def public_about
    @title = "about plus+"
  	@about = StaticPage.where(:static_key => 'about').first
  end
  #rss feed
  def rss_feed
  end
  # terms of use
  def terms
    @title = "terms of use"
    @tos = StaticPage.where(:static_key => 'tos').first
  end
  #faq
  def faq
    @title = "faq"
    @faq = StaticPage.where(:static_key => 'tos').first
  end
end
