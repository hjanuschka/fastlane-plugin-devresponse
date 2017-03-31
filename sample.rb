require "spaceship"
require "fastlane/plugin/devresponse"

Spaceship::Tunes.login("helmut@januschka.com")
app = Spaceship::Application.find("krone.at-fivexfive")

# get all reviews from AT
reviews = app.ratings.reviews("AT")
reviews.each do |review|
  if review.nickname == "h.ja"
    if review.responded?
      reviews.first.developer_response.update!("Many THX")
      puts "Modified Response"
    else
      # respond to this user
      review.developer_response.create!("Many Thx")
      puts "Created Response"
    end
  end
end
