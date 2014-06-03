class Predictor
  def initialize(name, domain)
    puts "Initialized!"
  end
end

puts "Please enter Advisor's full-name:"
name = gets.chomp.downcase

puts "Please enter Advisor's Domain:"
domain = gets.chomp.downcase

Predictor.new(name, domain)