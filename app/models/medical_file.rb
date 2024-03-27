class MedicalFile < ApplicationRecord
    belongs_to :user
    has_one_attached :pdf

    validates :pdf, presence: true

    private

    def validate_pdf_format
        if pdf.attached? && !pdf.blob.content_type.in?(%w(application/pdf))
          errors.add(:pdf, 'Musisz wybrać plik w formacie PDF.')
        end
    end


    def check_pdf_attachment
        if pdf.attached? && pdf.attachment
          Rails.logger.debug("PDF attached? true")
        else
          Rails.logger.debug("PDF attached? false")
        end
      end

end
