class CreateHeroes < ActiveRecord::Migration[5.2]
  def change
    create_table :heroes do |t|
      t.references :universe, foreign_key: true
      t.string :name
      t.string :real_name
      t.string :species

      t.timestamps
    end
  end
end
