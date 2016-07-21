class CreateJoinTableCategoryQuestion < ActiveRecord::Migration
  def change
    create_join_table :categories, :questions do |t|
      # t.index [:category_id, :question_id]
      # t.index [:question_id, :category_id]
    end
  end
end
