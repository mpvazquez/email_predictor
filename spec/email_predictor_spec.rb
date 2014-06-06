require 'spec_helper'
require_relative '../lib/email_predictor'

gem 'activemodel'
gem 'shoulda-matchers'

describe "predict email addresses" do
  let(:good_inputs) { Predictor.new("John Smith", "AlphaSights.com") }
  let(:good_inputs_not_in_db) { Predictor.new("Terry Jackson", "blue-sharks.co.uk")}
  let(:google_input) { Predictor.new("Merchant Mykonos", "google.com")}
  let(:bad_inputs) { Predictor.new("Johnny", "AlphaSights") }

  describe "by accepting input of advisor's full-name and email" do

    it "accepts a full name that is separated by a space" do
      expect(Predictor.validate_name(good_inputs.name)).to be_truthy
      expect(Predictor.validate_name(bad_inputs.name)).to be_falsy
      expect(Predictor.validate_name("Joanne ")).to be_falsy
      expect(Predictor.validate_name("     Joanne")).to be_falsy
    end

    it "validates without case-sensitivity" do
      expect(Predictor.validate_name(good_inputs.name)).to be_truthy
      expect(Predictor.validate_name("john smithy")).to be_truthy
      expect(Predictor.validate_domain(good_inputs.domain)).to be_truthy
      expect(Predictor.validate_domain("EXAMPLE.COM")).to be_truthy
    end

    it "rejects inputs that do not fit validations" do
      expect(Predictor.validate_domain(good_inputs_not_in_db.domain)).to be_truthy
      expect(Predictor.validate_name(bad_inputs.name)).to be_falsy
      expect(Predictor.validate_domain(bad_inputs.domain)).to be_falsy
    end

    it "validates that domain is in proper (dot) notation" do
      expect(Predictor.validate_domain(good_inputs_not_in_db.domain)).to be_truthy
      expect(Predictor.validate_domain("EXAMPLE")).to be_falsy
      expect(Predictor.validate_domain("example.3332")).to be_falsy
      expect(Predictor.validate_domain("@.3332")).to be_falsy
    end
  end

  describe "by analyzing past dataset of advisor emails" do
    it "compares database list of emails to given Advisor domain" do
      expect(good_inputs.find_domain_in_database).to be_truthy
      expect(good_inputs_not_in_db.find_domain_in_database).to be_falsy
    end

    it "returns false if no record of email is found in database" do
      expect(good_inputs_not_in_db.find_domain_in_database).to be_falsy
    end

    it "returns possible email matches if domain is found in database" do
      expect(good_inputs.find_domain_in_database.first.downcase).to match("john.smith@alphasights.com")
    end
  end

  describe "returns predicted email address based on past advisor emails" do
    it "prints to terminal possible email patterns" do 
      expect(good_inputs.find_domain_in_database.first.downcase).to match("john.smith@alphasights.com")
      expect(good_inputs_not_in_db.find_domain_in_database).to be_falsy
      expect(google_input.find_domain_in_database.first.downcase).to match("merchant.m@google.com").or match("m.mykonos@google.com")
      expect(google_input.find_domain_in_database.first.downcase).to match("merchant.m@google.com").or match("m.mykonos@google.com")
    end
  end
end 