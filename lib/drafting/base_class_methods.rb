module Drafting
  module BaseClassMethods
    ALLOWED_DRAFT_OPTION_KEYS = []

    def has_draft(options={})
      raise ArgumentError unless options.is_a?(Hash)
      raise ArgumentError unless options.keys.all? { |k| ALLOWED_DRAFT_OPTION_KEYS.include?(k) }

      include Drafting::InstanceMethods
      extend Drafting::ClassMethods

      has_one :draft, as: :parent, dependent: :destroy, autosave: false
      after_save :clear_draft
      attr_accessor :from_draft

    end
  end
end
