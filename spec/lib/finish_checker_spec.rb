require 'spec_helper'

describe LaundryAlert::FinishChecker do

  describe ".finished?" do
    context "washer" do
      let(:account) { create(:account,
        :low_threshold  => 50,
        :high_threshold => 500) }

      context "when a run hasn't reached the high threshold" do
        let(:run) { create(:washer_run,
          :account => account,
          :data    => '200,200,400,40,40') }

        it "returns false" do
          described_class.finished?(run).should == false
        end
      end

      context "when a run has reached the high threshold" do
        let(:run) { create(:washer_run,
          :account => account,
          :data    => '200,200,400,600,600') }

        it "returns false" do
          described_class.finished?(run).should == false
        end
      end

      context "when a run has reached the high for not enough time, then the low" do
        let(:run) { create(:washer_run,
          :account => account,
          :data    => '200,200,400,600,600,40') }

        it "returns false" do
          described_class.finished?(run).should == false
        end
      end

      context "when a run has reached the high for enough time, then the low" do
        let(:run) { create(:washer_run,
          :account => account,
          :data    => '200,200,400,600,600,600,40') }

        it "returns true" do
          described_class.finished?(run).should == true
        end
      end

      context "when a run has reached the high for not enough time, but then the low for 5" do
        let(:run) { create(:washer_run,
          :account => account,
          :data    => '200,200,400,600,40,40,40,40,40') }

        it "returns false" do
          described_class.finished?(run).should == false
        end
      end

      context "when a run has reached the high for not enough time, but then the low for 6" do
        let(:run) { create(:washer_run,
          :account => account,
          :data    => '200,200,400,600,40,40,40,40,40,40') }

        it "returns true" do
          described_class.finished?(run).should == true
        end
      end
    end

    context "with real datas" do
      let(:account) { create(:account,
        :low_threshold  => 125,
        :high_threshold => 400) }

      it "returns true" do
        run = create(:washer_run,
          :account => account,
          :data    => '0,100,93,90,88,432,241,319,85,118,855,227,236,251,217,242,241,226,225,189,173,183,168,160,256,146,244,268,311,101,89,90,92,269,328,309,337,357,176,342,373,383,693,428,421,371,86,94')

        described_class.finished?(run).should == true
      end

      it "returns true" do
        run = create(:washer_run,
          :account => account,
          :data    => '515,108,115,115,112,288,293,249,249,172,171,169,172,182,167,190,189,319,339,136,112,122,111,106,293,276,355,338,362,250,349,431,476,449,472,470,432,109,109')

        described_class.finished?(run).should == true
      end

      it "returns true" do
        run = create(:washer_run,
          :account => account,
          :data    => '91,91,92,269,277,362,298,254,94,884,299,323,315,288,325,342,299,229,186,212,198,210,219,283,176,330,452,333,91,90,96,89,332,310,331,326,299,211,812,499,515,506,506,503,479,87,87')

        described_class.finished?(run).should == true
      end

      # REMEMBER TO USE irt with new runs
    end
  end

end

