class AllUsersReport
  def initialize(user_ids, start_date: raise, end_date: raise)
    date_range = start_date..end_date
    @users = User.where(id: user_ids)
                 .where_activity_logs(checked_in_at: date_range,
                                      checked_out_at: date_range)
                 .includes(:activity_logs)
  end

  def to_json
    {
      title: "Worked hours for all users",
      columns: columns,
      data: data
    }.to_json
  end

  def columns
    ["User", "Email", "Worked hours"]
  end

  def data
    @users.map{|u| [ u.full_name, u.email, u.activity_logs.map(&:worked_hours).reduce(:+) ]}
  end
end
