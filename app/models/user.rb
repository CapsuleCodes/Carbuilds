class User < ActiveRecord::Base
    has_secure_password
    has_many :builds
    has_many :parts, through: :builds

end