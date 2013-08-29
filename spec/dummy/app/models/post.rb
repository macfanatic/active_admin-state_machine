class Post < ActiveRecord::Base
  attr_accessible :body, :status, :title

  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  DRAFT = 'draft'
  REVIEWED = 'reviewed'
  PUBLISHED = 'published'

  state_machine :status, initial: DRAFT do
    event :peer_review do
      transition DRAFT => REVIEWED
    end

    event :publish do
      transition REVIEWED => PUBLISHED
    end
  end
end
