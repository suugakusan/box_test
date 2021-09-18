class CreateBoxposts < ActiveRecord::Migration[6.1]
  def change
    create_table :boxposts do |t|
      t.integer :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
