class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :iso
      t.string :name

      t.timestamps
    end
  end
end
