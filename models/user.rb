class User < ActiveRecord::Base

  class << self

    def find_or_create_by_auth(auth)
      where(uid: auth['info']['uid']).first_or_create! do |user|
        user.name = auth['info']['name']
      end
    end

  end

end
