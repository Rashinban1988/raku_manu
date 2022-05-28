class CreateLearnings < ActiveRecord::Migration[6.1]
  def change
    create_table :learnings do |t|

      t.integer :employee_id
      t.integer :manual_id
      t.integer :is_learned,    default: false
      t.timestamps
    end
  end
end
