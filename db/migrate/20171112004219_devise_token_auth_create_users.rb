class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      ## Required
      t.string :provider, null: false, default: 'email'

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''
      t.string :uid, null: false, default: ''

      ## Tokens
      t.text :tokens

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, %i[uid provider], unique: true
  end
end
