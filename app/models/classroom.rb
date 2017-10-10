class Classroom < ActiveRecord::Base
    has_and_belongs_to_many :teachers, association_foreign_key: "user_id", join_table: "classrooms_teachers"
    has_and_belongs_to_many :students, association_foreign_key: "user_id", join_table: "classrooms_students"
    has_many :quizzes
end
