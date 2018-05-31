class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
  def change
    ## Required
    add_column :users, :provider, :string, :null => false, :default => "email"
    add_column :users, :uid, :string, :null => false, :default => ""
    ## Recoverable
    add_column :users, :allow_password_change, :boolean, :null => false, :default => false
    ## Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    ## tokens
    add_column :users, :tokens, :json

    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,       unique: true
  end
end
