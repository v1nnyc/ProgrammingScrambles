class QuestionImage < ActiveRecord::Base
    mount_uploader :image, ImagesUploader
    belongs_to :question
    validates :image, file_size: {less_than 3.megabytes}
end
