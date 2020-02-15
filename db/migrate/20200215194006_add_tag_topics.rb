class AddTagTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_topics do |t|
      t.string :topic
      t.integer :views

      t.timestamps
    end
  end
end
