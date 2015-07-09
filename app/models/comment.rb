class Comment < ActiveRecord::Base
  belongs_to :show
  belongs_to :user

  validates_presence_of :body, :show, :user
end
