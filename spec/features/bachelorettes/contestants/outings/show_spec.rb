require "rails_helper"

RSpec.describe "contestant's outings show page", type: :feature do
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

  it "when I click on an outing name, I'm taken to that outings show page" do
    visit "/bachelorettes/#{@bachelorette_20.id}/contestants/#{@contestant_3.id}/outings/#{@outing_1.id}"

    expect(page).to have_content(@outing_1.name)
    expect(page).to have_content(@outing_1.location)
    expect(page).to have_content(@outing_1.date.strftime("%m/%d/%y"))
    expect(page).to have_content("Count of Contestants: ")
  end
end