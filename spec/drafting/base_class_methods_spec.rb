require 'spec_helper'

describe Drafting::BaseClassMethods do
  describe :has_drafts do
    it "should not raise error" do
      expect {
        Post.has_draft
      }.to_not raise_error
    end
  end
end
