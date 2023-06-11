require "rails_helper"

RSpec.describe Bachelorette, type: :model do
  describe "relationships" do
    it { should have_many :contestants }
    it { should have_many(:contestant_outings).through(:contestants) }
    it { should have_many(:outings).through(:contestant_outings) }
  end
end
