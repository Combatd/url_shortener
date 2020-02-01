class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.email :string
      
      t.timestamps
    end

    add_index( :users,
      :email,
      { unique: true }
    )    
  end
end
