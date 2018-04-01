class Dog
  attr_accessor :name, :breed, :id

  def initialize(name:, breed:, id: nil)
    @name = name
    @breed = breed
    @id = id
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  end

  def save
    sql =  <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, @name, @breed)
    @id = DB[:conn].execute("SELECT last_inserted_row() FROM dogs")[0][0]
  end

  def self.create(name:,breed:)
    dog = Dog.new(name,breed)
    dog.save
    dog
  end




end
