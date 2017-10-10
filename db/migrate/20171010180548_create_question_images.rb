class CreateQuestionImages < ActiveRecord::Migration
  def change
    create_table :question_images do |t|

      t.timestamps null: false
    end
  end
end
