class Quiz < ActiveRecord::Base
    belongs_to :classrooms
    has_many :questions
end
