#NEW note or SEARCH notes

#SELECT * FROM notes;

require 'sqlite3'

db = SQLite3::Database.new("my_notes.db")

create_table = <<-SQL
  CREATE TABLE IF NOT EXISTS notes(
    id INTEGER PRIMARY KEY,
    category VARCHAR(255),
    name VARCHAR(255),
    note VARCHAR(500)
  )
SQL

db.execute(create_table)

def create_note(db, category, name, note)
  db.execute("INSERT INTO notes (category, name, note) VALUES (?, ?, ?)", [category, name, note])
end

#create_note(db, "html", "comments", "to create a comment in html use this syntax <!-- comments here -->")

def spacer
  puts "\n-------------------------\n"
end

def new_note(db)
  puts "\nWhat category would you like this note to be saved under?? examples html, css, ruby.....ect."
  category = gets.chomp

  puts "\nWhat would you like to name this note?? examples how to make a new line, how to round to the nearest whole number, ...ect "
  name = gets.chomp

  puts "\nAdd your note below"
  note = gets.chomp

  create_note(db, category, name, note)
end

#SELECT name, age FROM table_name;
#db.execute(SELECT name, age FROM table_name;)

# explore ORM by retrieving data
# kittens = db.execute("SELECT * FROM kittens")
# kittens.each do |kitten|
#  puts "#{kitten['name']} is #{kitten['age']}"
# end
def category_options(db)
  puts "\nChoose a catagory"
  my_category = db.execute("SELECT * FROM notes")
  options = []
  my_category.each do |category|
    options << category[1]
  end
  puts options.uniq!
end
#array.uniq!

# a = [ "a", "b", "c" ]
# a.include?("b")   #=> true
# a.include?("z")   #=> false
def catagory_results(db)

end






def search_note(db)
  puts "What category"
end

def initial_prompt(db)
  puts "To create a new note type NEW, to search notes Type SEARCH, to exit type EXIT"

  new_search = gets.chomp

  if new_search.downcase == "new"
    new_note(db)
  elsif new_search.downcase == "search"
    category_options(db)
  elsif new_search.downcase == "exit"
    puts "See you soon!"
  else
    spacer
    puts "\nThats not a choice\n"
    initial_prompt(db)
  end
end

initial_prompt(db)
#If new create entry

#If search go to search

#