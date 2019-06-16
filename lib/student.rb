class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # student_hash = {name: name, loc: loc}
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self 
  end

  def self.create_from_collection(students_array)
    # students_array = [{name: name, loc: loc}, {name: name, loc:...}]
    students_array.each do |student|
      self.new(student)
    end 
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    
  end
end

