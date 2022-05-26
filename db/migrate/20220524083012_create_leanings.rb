class CreateLeanings < ActiveRecord::Migration[6.1]
  def change
    create_table :leanings do |t|
      
      t.integer :employee_id
      t.integer :manual_id
      t.boolean :is_learned,        default: false
      t.timestamps
    end
  end
end
