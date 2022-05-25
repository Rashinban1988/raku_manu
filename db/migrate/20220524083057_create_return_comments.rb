class CreateReturnComments < ActiveRecord::Migration[6.1]
  def change
    create_table :return_comments do |t|

      t.timestamps
    end
  end
end
