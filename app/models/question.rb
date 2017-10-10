class Question < ActiveRecord::Base
    belongs_to :quizzes
    has_many :question_images
end
