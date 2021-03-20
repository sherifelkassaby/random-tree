class CreateNodesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :nodes do |t|
      t.string :node_id
      t.string :path
      t.string :tree_id

      t.timestamps
    end
  end
end
