class Student

  # the attr_accessor which is responsible for ready and writing of the various methods :name, :location, :twitter, :linkedin, 
  # :github, :blog, :profile_quote, :bio, :profile_url 
  
    attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 
  
  # class variable @@all set to an empty array 
  
    @@all = []
  
  # the initialize method takes in an argument of a hash and uses meta-programming to assign the newly created student
  # attributes and values per the key/value pairs of the hash. This was achieved using the send method. 
  # a class variable @@all was set to an empty array, during the initialize method we shoveled self into this array. 
  
    def initialize(student_hash)
      student_hash.each {|key,value| self.send(("#{key}="),value)}
      @@all << self
    end
  
  # this method self.create_from_collection takes in an argument of students_array. 
  # the students_array is then iterate over by using .each. 
  # students is then pass through the pipes and .new is then called on the student. 
  
    def self.create_from_collection(students_array)
      students_array.each { |student| Student.new(student)
      }
    end
  
  # The add_student_attributes method iterate over the given hash and use meta-programming to
  # assign the student attributes and values per the key/value pairs of the hash. 
  # the .each was use to iterate over the attributes_hash and self.send was used to ensure that the return value was the 
  # student self that was pass through that block. 
  
    def add_student_attributes(attributes_hash)
      attributes_hash.each {|key,value| self.send(("#{key}="),value)}
    end
  
  # the self.all is a class method that will return all the elements in that array. 
  
    def self.all
      @@all
    end
end
  
  