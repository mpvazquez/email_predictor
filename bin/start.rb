require_relative '../lib/classes/email_predictor'

####### Start Loop For User Input #######

puts "#######\nWelcome to Email Predictor!\n#######"

begin
  puts "Please enter Advisor's domain:"
  domain = gets.chomp
end until EmailPredictor.validate_domain(domain) == true

new_query = EmailPredictor.new(domain)

begin
  puts "Please enter Advisor's full-name:"
  name = gets.chomp
end until EmailPredictor.validate_name(name) == true

new_query.generate_email(name)