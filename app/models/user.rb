class User < ApplicationRecord

  validates :email,
            presence: true,
            uniqueness: true,
            format: /.+@.+\..+/i

  has_secure_password
  has_many :activity_logs
  before_create :downcase_email
  enum role: { admin: "admin", employee: "employee" }
  enum gender: { male: "m", female: "f" }

  Reducer = Rack::Reducer.new(
    User.where.not(role: "admin"),
    ->(first_name:) { where('lower(first_name) like ?', "%#{first_name.downcase}%") },
    ->(last_name:) { where('lower(last_name) like ?', "%#{last_name.downcase}%") },
    ->(email:) { where('lower(email) like ?', "%#{email.downcase}%") },
    ->(gender:) { where('lower(gender) like ?', "%#{gender.downcase}%") },
    ->(sort: 'id') { order(sort.to_sym) }
  )

  def self.where_activity_logs(filters)
    joins(:activity_logs).where(activity_logs: filters)
  end

  def as_json(options)
    res = super(options)
    res.delete("password_digest")
    res.delete("role")
    res.delete("created_at")
    res.delete("updated_at")
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
