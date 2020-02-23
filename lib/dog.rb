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
  id = row[0]  
  name = row[1]  
  breed = row[2] 
  Dog.new(id: id, name: name, breed: breed)
end 

def self.find_by_name(name)
  sql = "SELECT * FROM dogs WHERE name = ?"
  dog  = DB[:conn].execute(sql, name)[0]
  Dog.new_from_db(dog)

end 
  
def update
  sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
  DB[:conn].execute(sql, self.name, self.breed, self.id)
  
end 

  
  
  

end 