# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord


    validates :long_url, presence:true
    validates :short_url, uniqueness:true, presence:true
    after_initialize :generate_short_url
    # before_save :some_method, if :new_record?(self)


    def self.random_code
        encode = SecureRandom::urlsafe_base64
        if self.exists?(:short_url => encode)
            self.random_code
        end
        encode
    end

    def generate_short_url
        self.short_url = ShortenedUrl.random_code
    end

end
