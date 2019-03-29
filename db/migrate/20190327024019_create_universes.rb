class CreateUniverses < ActiveRecord::Migration[5.2]
  def change
    create_table :universes do |t|
      t.string :name

      t.timestamps
    end
  end
end
