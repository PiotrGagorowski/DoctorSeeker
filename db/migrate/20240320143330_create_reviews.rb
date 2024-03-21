class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.float :score
      t.text :comment

      t.timestamps
    end
  end
end
