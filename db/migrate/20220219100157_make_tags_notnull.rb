class MakeTagsNotnull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tags, :tagname, false, "TAGNAME"
  end
end
