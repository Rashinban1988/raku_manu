class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.integer :employee_id
      t.integer :manual_id
      t.string :comment
      t.boolean :is_desolved,       default: false
      t.timestamps
    end
  end
end
