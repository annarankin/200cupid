# Problem

Heroku doesn't support SQLite because its file system is empheral. Any changes
to any files, like our SQLite3 database file would be wiped out every 24 hours.

Heroku supports Postgres which runs on a separate server. This allows us to have
access database on Heroku.

Postgres is another RDMS that speaks a flavor of SQL. Because there are slight
variations between SQLite3 and postgres, our schema will have to differ slightly.

In Postgres we say `id SERIAL PRIMARY KEY` while in SQLite we say `id INTEGER PRIMARY KEY`.
Variations like this mean we'd have to make two copies of everything. One for our
local development environment and another for our production environment on heroku.

ActiveRecord can abstract away these differences by providing "migrations."

Migrations are database schema definitions written in Ruby that hide the specific
implemention details of each SQL flavor. We tell it make a table, and based on the
adapater ActiveRecord can create a table with either `id SERIAL` or `id INTEGER`

All we have to do is adhere to the syntax and ensure we set the right adapter
based on the environment.

# Steps to making a migration file

1. Create a "migrations" directory under "db"
1. Create your migration Ruby files inside "db/migrations"
1. Create individual migrations for each table or change to your database.
1. Create classes that inherit from "ActiveRecord::Migration"
1. Name your classes after the action you're taking.

```
# action_to_do.rb
class ActionToDo < ActiveRecord::Migration
end
```

1. Create two instance methods named "up" and "down" for your migration.
1. "up" is for what you want to do to your database.
1. "down" is how you would reverse it.

```
# action_to_do.rb
class ActionToDo < ActiveRecord::Migration
    def up
        create_table(:table_name)
    end
    def down
        drop_table(:table_name)
    end
end
```

1. ActiveRecord abstracts away different data types:

ActiveRecord | SQL
:--          | :--
| string     | VARCHAR
| text       | TEXT
| integer    | INTEGER
| boolean    | BOOLEAN
| date       | DATE
| time       | TIME
| datetime   | DATETIME

1. ActiveRecord Migration methods

```
create_table :users do |t|
  t.string :name
  t.text :description
  t.integer :weight
  t.boolean :is_admin
  t.date :born_on
  t.time :born_at
  t.datetime :created_at
  t.datetime :updated_at
end

add_column :users, :home_page_url, :string
remove_column :users, :home_page_url
rename_column :users, :email, :email_address
change_column :products, :part_number, :text
```

1. Running migrations.
1. Create a file called `db/migrate.rb`
1. Require all the migration files.
1. Call the class method `.migrate(:up)` on each migration.

```
# db/migrate.rb
require_relative("config")
require_relative("migrations/create_users.rb")
require_relative("migrations/change_username_to_email.rb")

CreateUsers.migrate(:up)
ChangeUsernameToEmail.migrate(:up)
```

This code might be volatile, so we can handle the errors
with a begin/rescue block.

```
begin
    # code that might throw an error
resuce => e
    # do this code if we have an error
end
```

# Tasks

1. Create a migration file for users
1. Create a migration file for visits
1. Create a migration file to remove the users column age and 
add the column "born_on" with the type Date 
