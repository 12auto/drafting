module Drafting
  module InstanceMethods
    def has_draft?
      self.draft.present?
    end

    def has_another_draft?
      self.has_draft? && !self.from_draft
    end

    def save_draft(user=nil)
      build_draft unless self.draft.present?
      draft.data = dump_to_draft
      draft.target_type = self.class.name
      draft.user = user
      draft.save
    end

    def update_draft(user, attributes)
      with_transaction_returning_status do
        assign_attributes(attributes)
        save_draft(user)
      end
    end

    # Override these two methods if you want to change the way to dump/load data
    def dump_to_draft
      Marshal.dump(instance_values)
    end

    def load_from_draft(string)
      values = Marshal.load(string)

      values.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
      self.from_draft = true
    end

  private

    def clear_draft
      self.draft&.destroy
    end

  end
end
