require 'pry'

###### Email Predictor Class #######

class Predictor
  def initialize(name, domain)
    @name = name
    @domain = domain
  end

  attr_accessor :name
  attr_accessor :domain

  def self.validate_name(name)
    split_name = name.split(" ")
    if split_name.count < 2
      puts "Valid name: 'John Smith'"
      return false
    else
      return true
    end
  end

  def self.validate_domain(domain)
    split_domain = domain.split(".")
    if split_domain.count < 2
      puts "Valid domain: 'example.com'"
      return false
    else 
      return true
    end
  end
end

###### Start Loop ########

begin
  puts "Please enter Advisor's full-name:"
  name = gets.chomp.downcase
end until Predictor.validate_name(name) == true

begin
  puts "Please enter Advisor's domain:"
  domain = gets.chomp.downcase
end until Predictor.validate_domain(domain) == true

new_query = Predictor.new(name, domain)
