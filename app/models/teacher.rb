class Teacher < ActiveRecord::Base
    has_and_belongs_to_many :classrooms, foreign_key: "user_id", join_table: "classrooms_teachers" 
end
