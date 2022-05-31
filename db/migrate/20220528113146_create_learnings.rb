class CreateLearnings < ActiveRecord::Migration[6.1]
  def change
    create_table :learnings do |t|

      t.references :employee, null: false, foreign_key: true
      t.references :manual, null:false, foreign_key: true
      t.boolean :is_learned,    default: true
      t.timestamps
    end
  end
end
