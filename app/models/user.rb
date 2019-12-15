class User < ApplicationRecord

  validates :email,
            presence: true,
            uniqueness: true,
            format: /.+@.+\..+/i

  has_many :activity_logs
  enum role: { admin: "admin", employee: "employee" }


  def activity_log
    ActivityLog.where(user: self, active: true).first_or_create
  end
end
