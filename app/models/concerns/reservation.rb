# frozen_string_literal: true

module Reservation
  extend ActiveSupport::Concern

  def close_reservation!
    update!(leave_date: Time.current)
  end

  def elapsed_time_in_words
    time = elapsed_time.zero? ? 1.minute : elapsed_time
    time.inspect
  end

  def left?
    !!leave_date
  end

  private

  def elapsed_time
    mm, ss = elapsed_time_in_seconds.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)

    [ dd.days, hh.hours, mm.minutes ].sum
  end

  def leave_datetime
    leave_date || Time.current
  end

  def elapsed_time_in_seconds
    (leave_datetime - created_at).round(2)
  end
end
