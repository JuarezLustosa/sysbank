require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TransactionsHelper. For example:
#
# describe TransactionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TransactionsHelper, type: :helper do
  describe "#change_color_tr" do
    let(:negative_item){ -1 }
    it  "return danger for negative item" do
     expect(helper.change_color_tr(negative_item)).to match /danger/
    end
  end
end
