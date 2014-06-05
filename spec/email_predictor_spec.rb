require 'spec_helper'
require_relative '../lib/email_predictor'

gem 'activemodel'
gem 'shoulda-matchers'

describe "predict email addresses" do
  describe "by accepting input of advisor's full-name and email" do
    let(:good_inputs) { Predictor.new("John Smith", "AlphaSights.com") }
    let(:bad_inputs) { Predictor.new("Johnny", "AlphaSights") }

    it "accepts a full name that is separated by a space" do
      expect(Predictor.validate_name(good_inputs.name)).to be_truthy
      expect(Predictor.validate_name(bad_inputs.name)).to be_falsey
      expect(Predictor.validate_name("Joanne ")).to be_falsey
      expect(Predictor.validate_name("     Joanne")).to be_falsey
    end

    it "splits full name based on the space" do

    end

    it "validates that input is lowercase" do

    end

    it "rejects inputs that do not fit the requirements" do

    end

    it "validates that domain is in proper (dot) notation" do

    end
  end

  describe "by analyzing past dataset of advisor emails" do

  end

  describe "returns predicted email address based on past advisor emails" do

  end
end 