class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  def self.find_or_create_by_auth auth_data
    user = find_or_initialize_by_provider_and_uid(auth_data["provider"],
                                                  auth_data["uid"])
    user.name = auth_data["info"]["name"]
    user.save!
    user
  end
end
