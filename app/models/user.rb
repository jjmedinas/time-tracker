class User < ApplicationRecord

  validates :email,
            presence: true,
            uniqueness: true,
            format: /.+@.+\..+/i

  has_many :activity_logs
  enum role: { admin: "admin", employee: "employee" }
end
