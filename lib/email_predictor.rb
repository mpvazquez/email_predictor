require 'pry'
require_relative 'email_database.rb'

###### Email Predictor Class #######

class Predictor
  include EmailDatabase

  def initialize(name, domain)
    @name = name
    @domain = domain
  end

  attr_accessor :name
  attr_accessor :domain

  def self.validate_name(name)
    split_name = name.split(" ")
    if split_name.count < 2
      puts "Valid Name Example: 'John Smith'"
      return false
    else
      return true
    end
  end

  def self.validate_domain(domain)
    if /[A-Z0-9.-]+\.[A-Z]{2,4}/i.match(domain) == nil
      puts "Valid Domain Example: 'example.com'"
      return false
    else 
      return true
    end
  end

  def find_domain_in_database
    @database = EmailDatabase::EmailList.new

    possible_email_matches = []

    @database.email_list.values.each do |email|
      db_domain = email.split("@")
      if domain.downcase.match(db_domain[1].downcase) != nil
        possible_email_matches << email
      end
    end

    evaluate_matching_domains(possible_email_matches)
  end

  def evaluate_matching_domains(array)
    if array.empty?
      puts "Sorry, no pattern recommendation available!"
      return false
    else 
      array.each do |email_address|
        pattern_matcher(email_address)
      end
    end
  end

  def pattern_matcher(db_email)
    name_from_db = @database.email_list.key(db_email).downcase.split(" ")
    email_pattern = db_email.split("@")[0].split(".")
    user_input_name = @name.split(" ")

    if name_from_db.first == email_pattern.first && name_from_db.last == email_pattern.last
      puts "Email pattern detected! Try: #{user_input_name.first}.#{user_input_name.last}@#{@domain}"
    elsif name_from_db.first[0] == email_pattern.first && name_from_db.last == email_pattern.last
      puts "Email pattern detected! Try: #{user_input_name.first[0]}.#{user_input_name.last}@#{@domain}"
    elsif name_from_db.first == email_pattern.first && name_from_db.last[0] == email_pattern.last
      puts "Email pattern detected! Try: #{user_input_name.first}.#{user_input_name.last[0]}@#{@domain}"
    elsif name_from_db.first[0] == email_pattern.first && name_from_db.last[0] == email_pattern.last
      puts "Email pattern detected! Try: #{user_input_name.first[0]}.#{user_input_name.last[0]}@#{@domain}"
    end
  end
end

###### Start Loop For User Input ########

begin
  puts "Please enter Advisor's full-name:"
  name = gets.chomp.downcase
end until Predictor.validate_name(name) == true

begin
  puts "Please enter Advisor's domain:"
  domain = gets.chomp.downcase
end until Predictor.validate_domain(domain) == true

new_query = Predictor.new(name, domain)
puts "Successful Input Validation! #{new_query.name.split(" ").first.capitalize} #{new_query.name.split(" ").last.capitalize}, #{new_query.domain}"

new_query.find_domain_in_database
