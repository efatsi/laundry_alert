class Account < ActiveRecord::Base

  validates :phone, :access_token, :core_id,
    :presence => true

  validates :phone, :length => {:is => 10}

  before_validation :strip_phone

  scope :watching, -> { where(:watching => true) }

  def core
    @core ||= RubySpark::Core.new(core_id, access_token)
  end

  def display_phone
    "(#{phone[0,3]}) #{phone[3,3]}-#{phone[6,4]}"
  end

  def twilio_phone
    "+1" + phone
  end

  private

  def strip_phone
    self.phone = phone.gsub(/[^0-9]/, "") if phone?
  end
end
