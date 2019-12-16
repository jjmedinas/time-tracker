class User < ApplicationRecord

  validates :email,
            presence: true,
            uniqueness: true,
            format: /.+@.+\..+/i

  has_secure_password
  has_many :activity_logs
  before_create :downcase_email
  enum role: { admin: "admin", employee: "employee" }

  def as_json(options)
    res = super(options)
    res.delete("password_digest")
    res
  end

  def activity_log
    ActivityLog.where(user: self, active: true).first_or_create
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  private

    def downcase_email
      email.downcase!
    end
end
