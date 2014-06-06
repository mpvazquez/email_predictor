require_relative '../lib/email_predictor'

describe "predict email addresses" do
  let(:good_inputs) { EmailPredictor.new("John Smith", "AlphaSights.com") }
  let(:good_inputs_not_in_db) { EmailPredictor.new("Terry Jackson", "blue-sharks.co.uk")}
  let(:google_input) { EmailPredictor.new("Merchant Mykonos", "google.com")}
  let(:bad_inputs) { EmailPredictor.new("Johnny", "AlphaSights") }

  describe "by accepting input of advisor's full-name and email" do

    it "accepts a full name that is separated by a space" do
      expect(EmailPredictor.validate_name(good_inputs.name)).to be_truthy
      expect(EmailPredictor.validate_name(bad_inputs.name)).to be_falsy
      expect(EmailPredictor.validate_name("Joanne ")).to be_falsy
      expect(EmailPredictor.validate_name("     Joanne")).to be_falsy
    end

    it "validates without case-sensitivity" do
      expect(EmailPredictor.validate_name(good_inputs.name)).to be_truthy
      expect(EmailPredictor.validate_name("john smithy")).to be_truthy
      expect(EmailPredictor.validate_domain(good_inputs.domain)).to be_truthy
      expect(EmailPredictor.validate_domain("EXAMPLE.COM")).to be_truthy
    end

    it "rejects inputs that do not fit validations" do
      expect(EmailPredictor.validate_domain(good_inputs_not_in_db.domain)).to be_truthy
      expect(EmailPredictor.validate_name(bad_inputs.name)).to be_falsy
      expect(EmailPredictor.validate_domain(bad_inputs.domain)).to be_falsy
    end

    it "validates that domain is in proper (dot) notation" do
      expect(EmailPredictor.validate_domain(good_inputs_not_in_db.domain)).to be_truthy
      expect(EmailPredictor.validate_domain("EXAMPLE")).to be_falsy
      expect(EmailPredictor.validate_domain("example.3332")).to be_falsy
      expect(EmailPredictor.validate_domain("@.3332")).to be_falsy
    end
  end

  describe "by analyzing email list in advisor database" do
    it "compares database email list to given Advisor domain input" do
      expect(good_inputs.find_domain_in_database).to be_truthy
      expect(google_input.find_domain_in_database).to be_truthy
      expect(good_inputs_not_in_db.find_domain_in_database).to be_falsy
    end

    it "returns false if no record of email is found in database" do
      expect(good_inputs_not_in_db.find_domain_in_database).to be_falsy
    end

    it "returns possible email matches if domain is found in database" do
      expect(good_inputs.find_domain_in_database.first).to match("john.smith@alphasights.com")
    end
  end

  describe "returns predicted email address based on past advisor emails" do
    it "prints to terminal possible email patterns" do 
      expect(good_inputs.find_domain_in_database.first).to match("john.smith@alphasights.com")
      expect(good_inputs_not_in_db.find_domain_in_database).to be_falsy
      expect(google_input.find_domain_in_database.first).to match("merchant.m@google.com").or match("m.mykonos@google.com")
      expect(google_input.find_domain_in_database.first).to match("merchant.m@google.com").or match("m.mykonos@google.com")
    end
  end
end 