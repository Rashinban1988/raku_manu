class CreateManuals < ActiveRecord::Migration[6.1]
  def change
    create_table :manuals do |t|

      t.integer :genre_id
      t.string :task_name
      t.string :description
      t.boolean :is_draft,       default: true
      t.timestamps
    end
  end
end
