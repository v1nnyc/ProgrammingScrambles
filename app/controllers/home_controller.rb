class HomeController < ApplicationController


  # Default index homepage for website.
  def index
    # Redirect to login for now.

  end

  # Shared page with various Options.
  def options
    render "devise/shared/_links"
  end

  private

end
