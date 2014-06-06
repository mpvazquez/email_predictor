require_relative '../modules/input_validator'
# require 'pry'
require 'json'

####### Email Predictor Class #######

class EmailPredictor
  # extends input_validator.rb module methods as class methods
  extend InputValidator

  def initialize(name, domain)
    @name = name.downcase
    @domain = domain.downcase
    # instance of email list database json
    json = File.read('data/email_database.json')
    @database = JSON.parse(json)
  end

  attr_reader :name
  attr_reader :domain

  def generate_email
    
  end

  # Main instance method that checks given inputs against database
  def find_domain_in_database
    possible_email_matches = []

    # iterate through each instance in the database if given 
    # domain matches a domain in the db's email list, 
    # we push that email into an array
    @database.values.each do |email_domain|
      db_domain = email_domain.split("@")
      if domain == db_domain[1]
        possible_email_matches << email_domain
      end
    end

    # call method that evaluates matching domains
    # against possible email matches array
    evaluate_matching_domains(possible_email_matches)
  end

  def evaluate_matching_domains(array)
    if array.empty?
      # if the array is empty, then we return no results
      puts "Sorry, no email pattern recommendation available!"
      return false
    else 
      possible_email_matches = []

      # iterate through array of possible matches and push
      # result of pattern_matcher method into array
      array.each do |email_address|
        possible_email_matches << pattern_matcher(email_address)
      end

      # eliminates duplicate email results from pattern_matcher
      possible_email_matches.uniq!

      # each possible email match is printed to terminal 
      puts "#{possible_email_matches.count} email pattern(s) detected! Try:"  
      possible_email_matches.each do |email| 
        puts "#{email}" 
      end
    end
  end

  # this method is called to return email based on the email pattern
  def pattern_matcher(email)
    db_name = @database.key(email).downcase.split(" ")
    domain_pattern = email.split("@")[0].split(".")
    user_input_name = name.split(" ")

    if db_name.first == domain_pattern.first && db_name.last == domain_pattern.last
      return "#{user_input_name.first}.#{user_input_name.last}@#{domain}"

    elsif db_name.first[0] == domain_pattern.first && db_name.last == domain_pattern.last
      return "#{user_input_name.first[0]}.#{user_input_name.last}@#{domain}"

    elsif db_name.first == domain_pattern.first && db_name.last[0] == domain_pattern.last
      return "#{user_input_name.first}.#{user_input_name.last[0]}@#{domain}"

    elsif db_name.first[0] == domain_pattern.first && db_name.last[0] == domain_pattern.last
      return "#{user_input_name.first[0]}.#{user_input_name.last[0]}@#{domain}"
    end
  end
end
