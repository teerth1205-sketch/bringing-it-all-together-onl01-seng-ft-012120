class Dog 
attr_accessor :name, :breed, :id 

def initialize(id: nil, name:, breed:)
  @id = id
  @name = name 
  @breed = breed
end   

def self.create_table
  sql = "CREATE TABLE dogs (
  id INTEGER PRIMARY KEY, 
  name TEXT,
  breed TEXT
  )"
  DB[:conn].execute(sql)
end 

def self.drop_table 
  sql = "DROP TABLE dogs"
   DB[:conn].execute(sql)
end 
  
def save 
  sql = "INSERT INTO dogs (name, breed) VALUES (?, ?)"
   DB[:conn].execute(sql, self.name, self.breed)
 end 
 
def self.new_from_db(row)
  row[0] = id 
  row[1] = name 
  row[2] = breed
  Dog.new(id: id, name: name, breed: breed)
end 
  
  

end 