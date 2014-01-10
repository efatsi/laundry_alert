class Run < ActiveRecord::Base
  belongs_to :account

  validates :account, :machine_type, :presence => true
  validates :machine_type, :inclusion => { :in => %w(washer dryer) }

  scope :by_date, -> { order('created_at DESC') }

  def to_s
    created_at.strftime("#{machine_type.capitalize} - %b %_d, %_I:%M %P")
  end

  def add(reading)
    data_set = raw_data
    data_set += [reading]

    update_attributes(:data => data_set.join(","))
  end

  def finished?
    LaundryAlert::FinishChecker.finished?(self)
  end

  def raw_data
    @raw_data ||= begin
      data.present? ? data.split(",").map(&:to_i) : []
    end
  end

  def washer?
    machine_type == 'washer'
  end
end
