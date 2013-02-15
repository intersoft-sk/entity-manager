# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


owner = Owner.create_with_omniauth({"uid" => "12345", "provider" => "provider of credentials for owner 12345", "info" => {"name" => "Name of owner 12345"}})  

serial = 1

10.times do  
  uuid =  SecureRandom.uuid
  entity = {:uuid => "#{uuid}", :description => "description for entity #{uuid}", :schema => "urn:entityID:" }
	e = Entity.create!(entity)    
	1.upto(5) do  |x|
	  y = serial + x
  	lid = {:local_ID => "local ID #{y}", :name => "Name of entity with local ID #{y}",:description => "description of entity with local ID #{y}"}
  	lid = LocalIdentity.create!(lid)
		lid.owner = owner
		e.local_identities << lid
		serial += 1
	end
end
