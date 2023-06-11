require "rails_helper"

RSpec.describe "bachelorette contestants show page", type: :feature do
  before :each do
    @bachelorette_15 = Bachelorette.create!(name: "Hannah Brown", season_number: 15, season_description: "The Most Dramatic Season Yet!" )
    @bachelorette_20 = Bachelorette.create!(name: "Bach2", season_number: 20, season_description: "No wait, THIS is the most dramatic season yet" )

    @contestant_1 = @bachelorette_15.contestants.create!(name: "Pilot Pete", age: 34, hometown: "Irving, TX")
    @contestant_2 = @bachelorette_15.contestants.create!(name: "C2", age: 2, hometown: "Albany, NY")
    @contestant_3 = @bachelorette_20.contestants.create!(name: "Ben Higgins", age: 35, hometown: "Los Angeles, CA")
    @contestant_4 = @bachelorette_20.contestants.create!(name: "C4", age: 4, hometown: "Denver, CO")

    static_time_1 = Time.zone.parse('2023-04-13 00:50:37') #newest
    static_time_2 = Time.zone.parse('2023-03-13 00:50:37')
    static_time_3 = Time.zone.parse('2023-02-13 00:50:37') #oldest

    @outing_1 = Outing.create!(name: "Kickball", location: "Brooklyn, NY", date: static_time_1)
    @outing_2 = Outing.create!(name: "Hot Springs", location: "Glenwood Springs, CO", date: static_time_2)
    @outing_3 = Outing.create!(name: "Helicopter Ride", location: "Kauai, HI", date: static_time_3)

    ContestantOuting.create!(contestant_id: @contestant_3.id, outing_id: @outing_1.id)
    ContestantOuting.create!(contestant_id: @contestant_3.id, outing_id: @outing_2.id)
    ContestantOuting.create!(contestant_id: @contestant_3.id, outing_id: @outing_3.id)
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

  it "should display season number and season description that this contestant was on" do
    visit bachelorette_contestant_path(@bachelorette_20, @contestant_3)

    expect(page).to have_content("Name: #{@contestant_3.name}")
    expect(page).to have_content("Season #{@contestant_3.bachelorette.season_number} - #{@contestant_3.bachelorette.season_description}")
    expect(page).to have_content("Outings")

    within "#contestant-#{@contestant_3.id}-outings" do
      expect(page).to have_content(@outing_1.name)
      expect(page).to have_content(@outing_2.name)
      expect(page).to have_content(@outing_3.name)
    end
  end

  it "when I click on an outing name, I'm taken to that outings show page" do
    visit bachelorette_contestant_path(@bachelorette_20, @contestant_3)

    within "#contestant-#{@contestant_3.id}-outings" do
      expect(page).to have_link(@outing_1.name, href: "/bachelorette/#{@bachelorette_20.id}/contestants/#{@contestant_3.id}/outings/#{@outing_1.id}")
      expect(page).to have_link(@outing_2.name, href: "/bachelorette/#{@bachelorette_20.id}/contestants/#{@contestant_3.id}/outings/#{@outing_2.id}")
      expect(page).to have_link(@outing_3.name, href: "/bachelorette/#{@bachelorette_20.id}/contestants/#{@contestant_3.id}/outings/#{@outing_3.id}")
    end
  end
end