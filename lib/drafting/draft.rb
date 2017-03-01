class Draft < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, polymorphic: true, autosave: false

  validates_presence_of :data, :target_type

  def restore
    target_type.constantize.from_draft(self)
  end
end
