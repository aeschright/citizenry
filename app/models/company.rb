class Company < ActiveRecord::Base
  has_and_belongs_to_many :projects

  has_many :sponsorships
  has_many :groups, :through => :sponsorships

  has_many :employments
  has_many :employees, :through => :employments, :source => :person

  validates_presence_of :name

  def self.from_twitter(screen_name, twitter_token)
    twitterer = twitter_token.get("/users/show?screen_name=#{screen_name}")

    return self.new(
      :twitter => screen_name,
      :name => twitterer['name'],
      :description => twitterer['description'],
      :url => twitterer['url'],
      :logo_url => twitterer['profile_image_url']
    )
  end
end


# == Schema Information
#
# Table name: companies
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  url         :string(255)
#  twitter     :string(255)
#  address     :text
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  logo_url    :string(255)
#

