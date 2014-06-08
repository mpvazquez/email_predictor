require_relative '../modules/input_validator'
require_relative 'domain_query'
require 'pry'

####### Email Predictor Class #######

class EmailPredictor
  # extends input_validator.rb module methods as class methods
  extend InputValidator

  def initialize(domain)
    @domain = domain.downcase

    # returns array of matching domains, if any
    @domain_query = DomainQuery.new(@domain)
  end

  attr_reader :domain

  # generates email based on name input
  def generate_email(name)
    @name = name

    if @domain_query.matching_domains.empty?
      # if the array is empty, then we return no results
      puts "Sorry, no email pattern recommendation available!"
      return false
    else 
      possible_email_matches = []

      # iterate through array of possible matches and push
      # result of pattern_matcher method into array
      @domain_query.matching_domains.each do |email_address|
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
    db_name = @domain_query.full_list.key(email).downcase.split(" ")
    domain_pattern = email.split("@")[0].split(".")
    user_input_name = @name.split(" ")

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
