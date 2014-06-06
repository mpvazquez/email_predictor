# require 'pry'
require 'json'
require_relative 'email_database'

####### Email Predictor Class #######

class EmailPredictor

  def initialize(name, domain)
    @name = name.downcase
    @domain = domain.downcase
    # instance of email list database json
    json = File.read('data/email_database.json')
    @database = JSON.parse(json)
  end

  attr_reader :name
  attr_reader :domain

  def self.validate_name(name)

    # Class method that validates a user input name
    split_name = name.split(" ")
    if split_name.count < 2 && /^([A-Z][a-z]*((\s)))+[A-Z][a-z]*$/i.match(name) == nil
      puts "Valid Name Example: 'John Smith'"
      return false
    else
      return true
    end
  end

  # Class method that validates user input domain
  def self.validate_domain(domain)
    if /[A-Z0-9.-]+\.[A-Z]{2,4}/i.match(domain) == nil
      puts "Valid Domain Example: 'example.com'"
      return false
    else 
      return true
    end
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

####### Start Loop For User Input #######

begin
  puts "Please enter Advisor's full-name:"
  name = gets.chomp
end until EmailPredictor.validate_name(name) == true

begin
  puts "Please enter Advisor's domain:"
  domain = gets.chomp
end until EmailPredictor.validate_domain(domain) == true

new_query = EmailPredictor.new(name, domain)
puts "Successful Input Validation! #{new_query.name.split(" ").first.capitalize} #{new_query.name.split(" ").last.capitalize}, #{new_query.domain}"

new_query.find_domain_in_database
