class CreateResultsData < ActiveRecord::Migration[7.0]
  def change
    create_table :results_data do |t|
      t.string :subject
      t.datetime :timestamp
      t.decimal :marks

      t.timestamps
    end
  end
end
