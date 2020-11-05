class Event < ApplicationRecord
  validates :start_date, presence: true, if: :future_date
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }, if: :multiple_of_five?
  validates :title, presence: true, length: {in: 5..140}
  validates :description, presence: true, length: {in: 20..1000}
  validates :price, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true
  validate :event_picture?

  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :event_admin, class_name: "User"

  has_one_attached :event_picture

  def multiple_of_five?
    errors.add(:duration, ": La durée doit être un multiple de 5") unless duration % 5 == 0
  end

  def future_date
    errors.add(:start_date, ": Un événement ne peux pas être dans le passé") unless start_date > DateTime.now
  end

  def is_admin?(user)
    self.event_admin.id == user.id ? true : false
  end

  def is_registred?(user)
    if self.attendances
      self.attendances.find_by(user: user.id) ? true : false
    else 
      puts "n'a pas attendances"
      return
    end
  end

  def event_picture?
    errors.add(:event_picture, ": Veuillez ajouter une photo ") unless self.event_picture.attached? == true

    
  end
end