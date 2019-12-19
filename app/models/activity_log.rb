class ActivityLog < ApplicationRecord
  belongs_to :user

  def check_in!
    if can_check_in?
      update!(checked_in_at: DateTime.now)
    else
      self.errors.add(:check_in, I18n.t("errors.models.cant_check_in"))
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def check_out!
    if can_check_out?
      update!(checked_out_at: DateTime.now, active: false)
    else
      self.errors.add(:check_out, I18n.t("errors.models.cant_check_out"))
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def worked_hours
    if checked_in_at && checked_out_at
      ((checked_out_at - checked_in_at) / 1.hour.to_f).round(2)
    else
      0
    end
  end

  private
    def can_check_in?
      checked_in_at.nil? && checked_out_at.nil?
    end

    def can_check_out?
      checked_in_at.present? && checked_out_at.nil?
    end
end
