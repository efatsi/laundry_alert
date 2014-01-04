class Account < ActiveRecord::Base

  validates :phone, :access_token, :core_id,
    :presence => true

  validates :phone, :length => {:is => 10}

  before_validation :strip_phone

  has_many :runs

  scope :watching, -> { where(:watching => true) }

  def core
    @core ||= RubySpark::Tinker.new(core_id, access_token)
  end

  def display_phone
    "(#{phone[0,3]}) #{phone[3,3]}-#{phone[6,4]}"
  end

  def twilio_phone
    "+1" + phone
  end

  def watch(machine_type)
    runs.create(:machine_type => machine_type)
    update_attributes(:watching => true)
  end

  def get_data
    reading = core.variable("lastminute")
    latest_run.add(reading)
  end

  def configure
    # do something with latest_run
  end

  private

  def latest_run
    @latest_run ||= runs.last
  end

  def strip_phone
    self.phone = phone.gsub(/[^0-9]/, "") if phone?
  end
end
