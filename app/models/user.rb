class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :omniauthable, :validatable

  include DeviseTokenAuth::Concerns::User

  validates :first_name, length: { in: 2..50 }, allow_blank: true
  validates :last_name, length: { in: 2..50 }, allow_blank: true

  has_many :contacts

  def profile_json
    as_json(only: %i[id email first_name last_name
                     created_at updated_at])
  end
end
