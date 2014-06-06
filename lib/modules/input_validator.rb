module InputValidator
  def validate_name(name)

    # method validates a user input name
    split_name = name.split(" ")
    if split_name.count < 2 && /^([A-Z][a-z]*((\s)))+[A-Z][a-z]*$/i.match(name) == nil
      puts "Please try again! Valid Name Example: 'John Smith'"
      return false
    else
      return true
    end
  end

  # method validates user input domain
  def validate_domain(domain)
    if /[A-Z0-9.-]+\.[A-Z]{2,4}/i.match(domain) == nil
      puts "Please try again! Valid Domain Example: 'example.com'"
      return false
    else 
      return true
    end
  end
end