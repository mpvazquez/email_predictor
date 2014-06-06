require_relative '../lib/email_predictor'

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