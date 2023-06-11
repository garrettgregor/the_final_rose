class AddSeasonDescriptionToBachelorettes < ActiveRecord::Migration[7.0]
  def change
    add_column :bachelorettes, :season_description, :string
  end
end
