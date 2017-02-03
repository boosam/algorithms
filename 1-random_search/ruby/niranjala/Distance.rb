# script will profvide calculation fuctions


 #Haversine function
 # will take in array of  loc1 and loc2 [latitude, longitude]
 def distance(loc1, loc2)

     lat1 = loc1[0].to_f
     lon1 = loc1[1].to_f

     lat2 = loc2[0].to_f
     lon2 = loc2[1].to_f

     dLat = conv_deg_rad(lat2 - lat1)
     dLon = conv_deg_rad(lon2 - lon1)

     a = Math.sin(dLat/2) * Math.sin(dLat/2) +
         Math.cos(lat1/180 * Math::PI) * Math.cos(lat2/180 * Math::PI) *
         Math.sin(dLon/2) * Math.sin(dLon/2)

     c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

     d = 6371e3 * c #meters

     return d
  end


  # convert degrees to radians
def conv_deg_rad(value)
  (value/180) * Math::PI unless value.nil? or value == 0
end