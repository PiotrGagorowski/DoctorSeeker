class MedicalFile < ApplicationRecord
    belongs_to :user
    has_one_attached :file
  
    validates :file, presence: true
    validate :validate_file_format
    enum category: [:prescription, :lab_results, :photo]
    private
  
    def validate_file_format
      if file.attached?
        unless file.blob.content_type.in?(%w(application/pdf image/jpeg image/png))
          errors.add(:file, 'Musisz wybrać plik w formacie PDF, JPG lub PNG.')
        end
      end
    end
  end


