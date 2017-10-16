class WelcomeController < ApplicationController

  def index
    unless logged_in?
      redirect_to landing_path
    end
  end

  def landing

  end

  def about

  end

  def pricing

  end

  def blog
    file = File.read('app/views/welcome/blog_content.json')
    @content = JSON.parse(file)
    @images = ['farmer.jpg', 'mountain.JPG', 'irrigation.jpg']
  end

  def contact

  end

end
