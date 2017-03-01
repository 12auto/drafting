module Drafting
  module ClassMethods
    def from_draft(draft_or_id)
      draft = draft_or_id.is_a?(Draft) ? draft_or_id : Draft.find(draft_or_id)
      raise ArgumentError unless draft.target_type == name
      target = draft.target_type.constantize.new
      target.load_from_draft(draft.data)
      target.draft = draft
      target
    end

    def drafts(user=nil)
      Draft.where(target_type: self.name, parent: nil, user: user)
    end

  end
end
