class CreateLeanings < ActiveRecord::Migration[6.1]
  def change
    create_table :leanings do |t|

      t.timestamps
    end
  end
end
