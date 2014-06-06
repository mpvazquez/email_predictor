require_relative '../lib/classes/email_predictor'

####### Start Loop For User Input #######

puts "#######\nWelcome to Email Predictor!\n#######"

begin
  puts "Please enter Advisor's domain:"
  domain = gets.chomp
end until EmailPredictor.validate_domain(domain) == true

begin
  puts "Please enter Advisor's full-name:"
  name = gets.chomp
end until EmailPredictor.validate_name(name) == true

new_query = EmailPredictor.new(name, domain)
puts "#######\nSuccessful Input Validation! #{new_query.name.split(" ").first.capitalize} #{new_query.name.split(" ").last.capitalize}, #{new_query.domain}\n#######"

new_query.find_domain_in_database