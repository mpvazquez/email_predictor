module EmailDatabase

  class EmailList
    def initialize
      @email_list = {
        "John Ferguson" => "john.ferguson@alphasights.com",
        "Damon Aw" => "damon.aw@alphasights.com",
        "Linda Li" => "linda.li@alphasights.com",
        "Larry Page" => "larry.p@google.com",
        "Sergey Brin" => "s.brin@google.com",
        "Steve Jobs" => "s.j@apple.com"
      }
    end

    attr_accessor :email_list
  end

end