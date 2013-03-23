class Owner < ActiveRecord::Base
#  attr_protected :uid, :provider, :name
  has_many :local_identities
  has_many :entities, :through => :local_identities
  @@anonymous = Owner.create!(:provider => 'default', :uid => '123456789', :name => 'anonymous')
  def self.anonymous
    return @@anonymous 
  end
  
  def self.create_with_omniauth(auth)
    Owner.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"])
  end
end
