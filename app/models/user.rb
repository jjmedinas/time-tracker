class User < ApplicationRecord

  validates :email,
            presence: true,
            uniqueness: true

  has_many :activity_logs
  enum role: { admin: "admin", employee: "employee" }
end
