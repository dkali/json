require_relative 'myJson.rb'
require 'json'

test_str1 = '{ "first_name" : "Sammy", "last_name" : 5,  "online" : true }'
test_str2 = '{ "first\"_name" : "Sammy", "last_name": "Shark",  "online" : true }'
test_str3 = '{ "first_name" : 5,  "online" : true }'

jp = MyJson.new
obj = jp.process_string(test_str3)
puts obj



# require 'json'

# my_hash = {:hello => "goo\"dbye"}
# str =  JSON.generate(my_hash)# => "{\"hello\":\"goodbye\"}"
# puts str
