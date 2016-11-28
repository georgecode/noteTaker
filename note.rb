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



# method for createing notes in sql db
def create_note(db, category, name, note)
  db.execute("INSERT INTO notes (category, name, note) VALUES (?, ?, ?)", [category, name, note])
end


def spacer
  puts "\n----------------------------\n"
end

# method creates a new note
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

# method returns a list of catagories available
def category_options(db)
  my_category = db.execute("SELECT * FROM notes")
  options = []
  my_category.each do |category|
    options << category[1]
  end
  options.uniq!
end

# method checks to see if user made a valid choice
def category_results(db,options)
  puts "\nChoose a catagory"
  puts options
  choice = gets.chomp
  if options.include?(choice)
    puts "you chose #{choice}"
    choice
  else
    puts "\nThats not a choice"
    category_results(db,options)
  end
end

# catagory_results(db,category_options(db))
search_category = category_results(db,category_options(db))



#method prints search results
def search_results(db,choice)
  spacer
  puts "----- RESULTS FOR #{choice.upcase} -----"
  data =db.execute("SELECT * FROM notes")
  data.each do |note|
    if note[1] == choice
      puts "\n #{note[2]} - #{note[3]}"
    end
  end
  spacer
end

search_results(db,search_category)

#-----------------------------------------
def search_note(db)
  puts "What category"
end

def initial_prompt(db,options)
  puts "To create a new note type NEW, to search notes Type SEARCH, to exit type EXIT"

  new_search = gets.chomp

  if new_search.downcase == "new"
    new_note(db)
  elsif new_search.downcase == "search"
    puts "good search"
    catagory_results(db,options)

  elsif new_search.downcase == "exit"
    puts "See you soon!"
  else
    spacer
    puts "\nThats not a choice\n"
    initial_prompt(db)
  end
end

initial_prompt(db, category_options(db))
#If new create entry

#If search go to search

#