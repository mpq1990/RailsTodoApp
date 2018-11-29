class User < ApplicationRecord
    has_secure_password
    # association
    has_many :todos, foreign_key: :created_by

    # validation
    validates_presence_of :name, :email, :password_digest
end
