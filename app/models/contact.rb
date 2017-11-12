class Contact < ApplicationRecord
  belongs_to :user, required: true

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, length: { in: 2..50 }, allow_blank: true

  validates :address, length: { in: 5..250 }, allow_blank: true

  validates :phone, presence: true,
                    format: { with: /(\D*\d){8}/, message: 'Invalid phone' }
end
