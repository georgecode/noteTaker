#NEW note or SEARCH notes
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

def spacer
  puts "\n-------------------------\n"
end

def initial_prompt
  puts "To create a new note type NEW, to search notes Type SEARCH, to exit type EXIT"

  new_search = gets.chomp

  if new_search.downcase == "new"
    puts "good new "
  elsif new_search.downcase == "search"
    puts "good search"
  elsif new_search.downcase == "exit"
    puts "See you soon!"
  else
    spacer
    puts "\nThats not a choice\n"
    initial_prompt
  end
end

initial_prompt
#If new create entry

#If search go to search

#