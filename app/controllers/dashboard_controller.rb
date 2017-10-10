# TODO: Move class to library and use partials to show dashboard.
class DashboardController < ApplicationController

  devise_group :user, contains: [:teacher, :student, :user]
  before_action :authenticate_user!

  # GET dashboard/index
  ##
  # Function to redirect to proper classrooms page.
  #
  def index
    if student_logged_in?
      redirect_to "/student_classroom"
    else
      redirect_to "/teacher_classroom"
    end
  end


end
