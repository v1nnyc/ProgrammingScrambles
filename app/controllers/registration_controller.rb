##
# Controller used for figuring out what
# type of registration.
class RegistrationController < ApplicationController

  # Prebuilt layout for each pages
  layout :resolve_layout

  # GET registration/index
  def index

  end

  # GET registration/new
  def new

  end

  # POST registration/create
  def create

    if params[:user_select] == "Teacher"
      redirect_to "/teachers/sign_up"
    else
      redirect_to "/students/sign_up"
    end
  end

  # Decide which layout to print
  def resolve_layout
    case action_name
      when "create", "new", "index"
        "useraccount_layout"
      else
        "application"
    end
  end

end