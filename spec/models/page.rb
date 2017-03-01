class Page < ActiveRecord::Base
  has_draft

  validates_presence_of :title, :content
end
