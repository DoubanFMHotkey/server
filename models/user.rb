class User < ActiveRecord::Base

  has_one :api_key

  class << self

    def find_or_create_by_auth(auth)
      where(uid: auth['info']['uid']).first_or_create! do |user|
        user.name = auth['info']['name']
        user.api_key = ApiKey.create!
      end
    end

  end

end
