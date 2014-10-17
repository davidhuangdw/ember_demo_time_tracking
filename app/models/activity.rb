class Activity < ActiveRecord::Base
  validates_presence_of :title, :begin_at, :end_at
  validate do
    unless begin_at && end_at && begin_at < end_at
      errors.add(:begin_at, "begin should before end")
      errors.add(:end_at, "begin should before end")
    end
  end

  default_scope ->{ order('begin_at') }
end
