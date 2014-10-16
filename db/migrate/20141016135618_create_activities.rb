class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.datetime :begin_at
      t.datetime :end_at
      t.text :description

      t.timestamps
    end
  end
end
