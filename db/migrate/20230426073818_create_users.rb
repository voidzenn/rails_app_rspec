class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :fname, null: true
      t.string :lname, null: true
      t.integer :age, null: true
      t.string :location, null: true
      t.string :email, null: true, unique: true
      t.string :password, null: true

      t.timestamps
    end
  end
end
