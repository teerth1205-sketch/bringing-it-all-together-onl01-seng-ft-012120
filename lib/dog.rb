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
  if self.id 
    self.update
  else 
  sql = "INSERT INTO dogs (name, breed) VALUES (?, ?)"
   DB[:conn].execute(sql, self.name, self.breed)
   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
 end
 Dog.new(id: self.id, name: self.name, breed: self.breed) 
 end 
 
def self.new_from_db(row)
  id = row[0]  
  name = row[1]  
  breed = row[2] 
  self.new(id: id, name: name, breed: breed)
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

def self.create(name:, breed:)
 dog =  Dog.new(name: name , breed: breed)
 dog.save 
 dog
end 
  
def self.find_or_create_by(name:, breed:)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
    if !dog.empty?
      song_data = dog[0]
      dog = Dog.new(id: song_data[0], name: song_data[1], breed: song_data[2])
    else
      dog = self.create(name: name, breed: breed)
    end
    dog
  end

def self.find_by_id(id)
  sql = "SELECT * FROM dogs WHERE id = ?"
dog = DB[:conn].execute(sql, id)
  Dog.new_from_db(dog)
end 

end 