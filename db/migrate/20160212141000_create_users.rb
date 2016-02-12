class CreateUsers < ActiveRecord::Migration

  attr_reader :password_hash, :password_salt

  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.text :email
      t.string :password_hash
      t.string :password_salt
      t.timestamp
    end
  end
end
