class ResumesController < ApplicationController
  def twitter
    user = User.find_by(username: params[:username])
    tweets = user.user_tweet.tweets

    tweets.map {|t| t.to_json} #should return an array
  end

  def github
    github_data = User.find_by(user_name: params[:username]).github_profile

    github_data.to_json
  end

  def email
    puts '*' * 50
    puts '*' * 50
    puts 'SENDING EMAIL'
    puts params
    puts '*' * 50
    puts '*' * 50
    UserMailer.share_email(params).deliver_now
    
    render nothing: true
  end
end