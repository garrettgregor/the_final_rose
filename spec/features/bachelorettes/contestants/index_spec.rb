require "rails_helper"

RSpec.describe "bachelorette contestants index page", type: :feature do
  before :each do
    @bachelorette_15 = Bachelorette.create!(name: "Hannah Brown", season_number: 15, season_description: "The Most Dramatic Season Yet!" )
    @bachelorette_20 = Bachelorette.create!(name: "Bach2", season_number: 20, season_description: "No wait, THIS is the most dramatic season yet" )

    @contestant_1 = @bachelorette_15.contestants.create!(name: "Pilot Pete", age: 34, hometown: "Irving, TX")
    @contestant_2 = @bachelorette_15.contestants.create!(name: "C2", age: 2, hometown: "Albany, NY")
    @contestant_3 = @bachelorette_20.contestants.create!(name: "C3", age: 3, hometown: "LA, CA")
    @contestant_4 = @bachelorette_20.contestants.create!(name: "C4", age: 4, hometown: "Denver, CO")
  end

  it "should display only that seasons contestants" do
    visit bachelorette_contestants_path(@bachelorette_15)

    expect(page).to have_content(@contestant_1.name)
    expect(page).to have_content(@contestant_2.name)
    expect(page).to_not have_content(@contestant_3.name)
    expect(page).to_not have_content(@contestant_4.name)
  end

  it "should display contestants' information" do
    visit bachelorette_contestants_path(@bachelorette_15)

    within "#contestant-#{@contestant_1.id}" do
      expect(page).to have_content("Name: #{@contestant_1.name}, Age: #{@contestant_1.age}, Hometown: #{@contestant_1.hometown}")
      expect(page).to have_link("#{@contestant_1.name}", href: bachelorette_contestant_path(@bachelorette_15, @contestant_1))
      expect(page).to_not have_content("Name: #{@contestant_3.name}, Age: #{@contestant_3.age}, Hometown: #{@contestant_3.hometown}")
    end

    within "#contestant-#{@contestant_2.id}" do
      expect(page).to have_content("Name: #{@contestant_2.name}, Age: #{@contestant_2.age}, Hometown: #{@contestant_2.hometown}")
      expect(page).to have_link("#{@contestant_2.name}", href: bachelorette_contestant_path(@bachelorette_15, @contestant_2))
      expect(page).to_not have_content("Name: #{@contestant_3.name}, Age: #{@contestant_3.age}, Hometown: #{@contestant_3.hometown}")
    end
  end

end