class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :user
  belongs_to :event_admin, class_name: "User"
  
  validates_presence_of :start_date
  validate :start_must_be_before_date_now 
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validate :multiple_of_five?
  validates :title, length: {minimum: 5, maximum: 140}, presence: true
  validates :description, length: {minimum: 20, maximum: 1000}, presence: true
  validates :price, numericality: {only_integer: true, greater_than: 0, less_than: 1000}
  validates :location, presence: true

  def start_must_be_before_date_now
    errors.add(:start_date, "Can't create a event in the past") unless :start_date > Date.now
  end 

  def multiple_of_five?
    errors.add(:duration, "should be a multiple of 5.") unless duration % 5 == 0
  end

end
