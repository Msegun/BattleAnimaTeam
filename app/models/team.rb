class Team < ApplicationRecord
  has_attached_file :image, styles: { medium: "100x100>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :players
  validates :name, :length => { :in => 3..20 }, :format => { :with => /\A[A-Za-z-. ]+\z/ }
  validate :date_of_founding_in_future?
  validate :team_name_unique?
  validates :image, presence: true

  private

  def team_name_unique?
    if Team.where.not(id: self.id).exists?(:name=>self.name)
      errors.add("Team with that name", "already exists")
    end
  end

  def date_of_founding_in_future?
   if self.date_of_founding > Date.today
     errors.add("Date of founding", "cannot be in the future")
   end
  end
end
