# devresponse plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-devresponse)

Enables you to retreive app-reviews and also answer them

# Sample

```ruby
lane :reply_all_unanswered do
  Spaceship::Tunes.login("helmut@januschka.com")
  app = Spaceship::Application.find("krone.at-fivexfive")


  # get all reviews from AT
  reviews = app.ratings.reviews("AT")
  
  # iterate over each review - thx the 4+ and apologize all below
  reviews.each do | review |
      if review.rating >= 4
        response_message = "Many Thx for your kind feedback and the awesome rating 🎉"
     else
       response_message = "We are really sorry 💔 that you have troubles with the app - feel free to contact us directly at app@domain.com - to get technical assistance!"
      end
       # which not yet have gotten a dev response
       unless review.responded?
           # respond to this user
          review.developer_response.create!(response_message)
       end
  end

  # here is a sample of editing a existing developer response
  if reviews.first.responded?
       reviews.first.developer_response.update!("First you where awesome 👏 but now you are 🚀")
  end
end

```

run with `fastlane reply_all_unanswered`
