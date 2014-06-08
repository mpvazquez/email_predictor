require 'json'
# require 'pry'

####### Class queries data from database using domain input #######

class DomainQuery
  def initialize(domain)
    @domain = domain
    # email list from json database
    json = File.read('data/email_database.json')
    @email_database = JSON.parse(json)
  end

  attr_reader :domain

  # checks given domain to find matches in database
  def matching_domains
    possible_email_matches = []

    # iterates through each instance in the database.  
    # push email matches into an array
    @email_database.values.each do |email|
      saved_domain = email.split("@")
      if domain == saved_domain[1]
        possible_email_matches << email
      end
    end

    return possible_email_matches
  end

  def full_list
    return @email_database
  end
end