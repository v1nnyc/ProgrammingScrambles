class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Required STI Overrides for Helpers
  helper_method :current_teacher, :current_student,
                :require_teacher!, :required_student!

  ##
  # Function to get account url.
  def account_url
    return new_user_session_url unless user_signed_in?
      return  :user_dashboard_url
    end
  end

  ##
  # Helper function to call for getting path after sign in
  # given specific resource name.
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || account_url
  end

  ##
  # Custom authentication function in order to get registration
  def auth_user
    redirect_to new_user_session_url unless user_signed_in?
  end

  private

  # OPTIMIZATION: Use dynamic function to generate.

  # Helper functions for dashboard checking. #
  # Helper function to help check all the given options.
  # Used for alleviating sql searches by having url store id info.
  def check_valid_question(classroom_id, quiz_id, question_id)
    if !check_valid_quiz(classroom_id, quiz_id)
      return false
    end

    @question = Question.find_by(id: question_id)
    if @question == nil
      flash[:error] = "Error, question does not exist."
      redirect_to controller: :question, action: :index, classroom_id: classroom_id, quiz_id: quiz_id
      return false
    end

    return @question
  end

  # Helper function to help check both classroom id and
  # quiz id passed results.
  # Uses check_valid_classroom as helper function.
  # Also sets @quiz and @classroom for convenience.
  # Sets up redirection as well for easy use.
  def check_valid_quiz(classroom_id, quiz_id)
    if !check_valid_classroom(classroom_id)
      return false
    end

    @quiz = Quiz.find_by(id: quiz_id)
    if @quiz == nil
      flash[:error] = "Error, quiz does not exist."
      redirect_to controller: :quiz, action: :index, classroom_id: classroom_id
      return false
    end

    return @quiz
  end

  # Helper function to check if classroom id is valid and associated
  # with user. Sets @classroom if valid.
  # Also sets @classroom for convenience.
  # Sets up redirection as well for easy use.
  def check_valid_classroom(id)
    @classroom = Classroom.find_by(id: id)

    # Check if classroom is valid
    if @classroom == nil
      flash[:error] = "Error, classroom does not exist."
      redirect_to class_redirect
      return false
    end

    # Check if user is an author is in class.
    if !@classroom.teachers.exists?(current_user.id) and !@classroom.students.exists?(current_user.id)
      flash[:error] = "User is not associated with this class."
      redirect_to class_redirect
      return false
    end

    return @classroom
  end

  # Override the inherited users. Thank you adamrobbie.me for the
  # template code :O

  ##
  # Function to retun the user object if they are a student nil otherwise.
  #
  def cur_student
    @current_student ||= current_user if user_signed_in? and current_user.class.name == "Student"
  end

  ##
  # Function to return the user object if they are a teacher nil otherwise.
  #
  def cur_teacher
    @current_teacher ||= current_user if user_signed_in? and current_user.class.name == "Teacher"
  end

  ##
  # Boolean function to check if a user is a student. Returns
  # true if user is a student.
  #
  def student_logged_in?
    @student_logged_in ||= user_signed_in? and cur_student
  end

  ##
  # Boolean function to check if user is a teacher. Returns
  # true if user is a teacher.
  #
  def teacher_logged_in?
    @teacher_logged_in ||= user_signed_in? and cur_teacher
  end

  ##
  # Function to make sure that user is a student. If not,
  # will redirect to root directory.
  #
  def required_student
    require_user_type(:student)
  end

  ##
  # Function to make sure that user is a teacher. If not,
  # will redirect to root directory.
  #
  def required_teacher
    require_user_type(:teacher)
  end

  ##
  # Generic function used by required_ for checking user status and
  # redirection.
  #
  def require_user_type(user_type)
    if (user_type == :student and !student_logged_in?) or (user_type == :teacher and !teacher_logged_in?)
      redirect_to root_path, status: 301, notice: "You must be logged in a#{'n' if user_type == :admin} #{user_type} to access this content"
      return false
    end
  end
