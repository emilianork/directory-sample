class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :contacts, %i[user_id id], unique: true
  end
end
