require "rails_helper"

RSpec.describe "bachelorette show page", type: :feature do
  before :each do
    @bachelorette_15 = Bachelorette.create!(name: "Hannah Brown", season_number: 15, season_description: "The Most Dramatic Season Yet!" )
    @bachelorette_20 = Bachelorette.create!(name: "Bach2", season_number: 20, season_description: "No wait, THIS is the most dramatic season yet" )

    @contestant_1 = @bachelorette_15.contestants.create!(name: "C1", age: 1, hometown: "Manhattan, NY")
    @contestant_2 = @bachelorette_15.contestants.create!(name: "C2", age: 2, hometown: "Albany, NY")
    @contestant_3 = @bachelorette_20.contestants.create!(name: "C3", age: 3, hometown: "LA, CA")
    @contestant_4 = @bachelorette_20.contestants.create!(name: "C4", age: 4, hometown: "Denver, CO")
  end

  it "should display a specific bachelorette's name, season number and description of the season they were on" do
    visit bachelorette_path(@bachelorette_15)

    expect(page).to have_content("Name: #{@bachelorette_15.name}")
    expect(page).to have_content("Season Number: #{@bachelorette_15.season_number}")
    expect(page).to have_content("Season Description: #{@bachelorette_15.season_description}")
    expect(page).to_not have_content("Name: #{@bachelorette_20.name}")
    expect(page).to_not have_content("Season Number: #{@bachelorette_20.season_number}")
    expect(page).to_not have_content("Season Description: #{@bachelorette_20.season_description}")
  end

  it "has a link to that season's contestants" do
    visit bachelorette_path(@bachelorette_15)

    expect(page).to have_link("#{@bachelorette_15.name}'s Contestants", href: bachelorette_contestants_path(@bachelorette_15))
  end

end