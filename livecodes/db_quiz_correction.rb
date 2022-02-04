# Q1 - What’s a relational database?
# It's a database with relations between tables 🤷‍♂️
# They are linked to each other by a system of primary keys and foreign keys

# Q2 - What are the different “table relationships” you know?
# 1 to 1
# 1 to many
# many to many

# Q3 and Q4
# https://kitt.lewagon.com/db/52765

# Q5 - What’s the language to make queries to a database?
# SQL - Structured Query Language

# Q6 - What’s the SQL query to get books written before 1985?

# SELECT * FROM books
# WHERE publishing_year < 1985;

# Q7 - What’s the SQL query to get the 3 most recent books written by Jules Verne?

# SELECT * FROM books
# JOIN authors ON books.author_id = authors.id
# WHERE authors.name = 'Jules Verne'
# ORDER BY books.publishing_year DESC
# LIMIT 3;

# Q8 - What’s the purpose of Active Record?
# The purpose of ActiveRecord is to generate SQL queries through Ruby methods;
# Each model in the ruby MVC will be a table in the SQL database;
  # and the columns in the db will be instance variable in AR.

# Q9 - What’s a migration?
# Is the way to change the STRUCTURE / SQUEMA of the database
# Tables, columns and relations

# Q10 - How do you run a migration?
# rake db:migrate

# Q11 - Complete the following migrations to create your e-library database.

class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name

      t.timestamps
    end
  end
end

# Q12 - Complete the following migrations to create your e-library database.

class CreateBooks < ActiveRecord::Migration[6.0]
 def change
  create_table :books do |t|
    t.string :title
    t.integer :publishing_year
    t.references :author, foreign_key: true

    t.timestamps
  end
 end
end

# Q13 - Complete the following migrations to create your e-library database.

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email

      t.timestamps
    end
  end
end

# Q14 - Complete the following migrations to create your e-library database.

class CreateReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :readings do |t|
      t.date :date
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

# Q15 - Write a migration to add a category column to the books table.

class AddCategoryToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :category, :string
  end
end

# Q16 - Define each Active Record model with its associations for your database.
# Hint: We’re working with 4 tables: authors, books, users & readings. Therefore we need 4 models!

class Author
  has_many :books
end

class Book
  belongs_to :author
  has_many :readings
  has_many :users, through: :readings
end

class User
  has_many :readings
  has_many :books, through: :readings
end

class Reading
  belongs_to :book
  belongs_to :user
end

# Q17 - Complete the following code using the relevant Active Record methods.

#1. Add your favorite author to the DB
ariano = Author.new(name: "Ariano Suassuna")
ariano.save

Author.create(name: "Ariano Suassuna")

#2. Get all authors
Author.all # => [author1, author2, ...]

#3. Get author with id=8
Author.find(8) # => instance of Author

#4. Get author with name="Jules Verne", store it in a variable: jules
jules = Author.find_by(name: 'Jules Verne')

#5. Get Jules Verne's books
jules.books

#6. Create a new book "20000 Leagues under the Seas". Store it in a variable: twenty_thousand
twenty_thousand = Book.new(title: "20000 Leagues under the Seas", publishing_year: 1870, category: "Fiction")

#7. Add Jules Verne as this book's author
twenty_thousand.author = jules

#8. Now save this book in the DB!
twenty_thousand.save


# Q18 - Add validations of your choice to the Author class.

class Author
  validates :name, presence: true, uniqueness: true
end

# Q19 - Can we save an object in the DB if its validations do not pass?
# NO
