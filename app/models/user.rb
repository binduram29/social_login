class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :confirmable, :lockable, :timeoutable,
        :omniauthable, omniauth_providers: [:github,:twitter,:facebook]

  def self.create_from_provider_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        user.email = provider_data.info.email 
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
      end  
  end

  def self.create_from_twitter_provider_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        #user.email = provider_data.info[:nickname] unless provider_data.info.email
        provider_data.info
        user.email = provider_data.info[:nickname]+"@gmail.com" if provider_data.info.nickname
        binding.pry
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
      end
  end  

end