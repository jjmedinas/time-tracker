class UserReport
  attr_accessor :user, :activity_logs

  def initialize(user)
    @user = user
    @activity_logs = @user.activity_logs
  end

  def to_json
    {
      columns: columns,
      data: data
    }.to_json
  end

  def columns
    ["ID", "Day", "Check in at", "Check out at", "Worked hours"]
  end

  def data
    @data ||= @activity_logs.map{|a|
      [
        a.id, a.checked_in_at.try(:strftime, "%b %e, %Y"),
        a.checked_in_at.try(:strftime, "%H:%M"),
        a.checked_out_at.try(:strftime, "%H:%M"),
        a.worked_hours
      ]
    }
  end

end
