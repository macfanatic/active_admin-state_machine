class Post < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  DRAFT = 'draft'
  REVIEWED = 'reviewed'
  PUBLISHED = 'published'
  ARCHIVED = 'archived'

  state_machine :status, initial: DRAFT do
    event :peer_review do
      transition DRAFT => REVIEWED
    end

    event :publish do
      transition REVIEWED => PUBLISHED
    end

    event :archive do
      transition any - ARCHIVED => ARCHIVED
    end

    event :reopen do
      transition any - DRAFT => DRAFT
    end
  end
end
