class CreateManuals < ActiveRecord::Migration[6.1]
  def change
    create_table :manuals do |t|

      t.timestamps
    end
  end
end
