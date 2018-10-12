require_relative 'myJson.rb'
require 'json'

tests = []
tests << '{ "first_name" : "Sammy", "last_name" : "Dickens"}'
tests << '{"first_name":"Sammy","last_name":"Dickens"}'

tests << '{ "first_name" : "Sammy", "last_name" : "Dickens",  "online" : true }'
tests << '{ "first_name" : "Sammy", "last_name" : "Dickens",  "online" : true}'

tests << '{"string":"goodbye","fixnum":6,"float": 48.9}'
tests << '{"string":"goodbye","fixnum":6,"float":48.9 }'
tests << '{"string":"goodbye","float":48.9, "fixnum":6 }'
tests << '{"string":"goodbye","float":48.9, "fixnum":6}'

tests << '{ "first\"_name" : "Sammy", "last_name" : "Dickens"}' #TODO double check

tests << '{"string":"goodbye","numbers":{"fixnum":6,"float":48.9}}'
tests << '{"string":"goodbye","numbers":{ "fixnum" : 6, "float" : 48.9 } }'

tests << '{"string":"goodbye","numbers":[1,2,3,4,5,6.7]}'
tests << '{"string" : "goodbye" , "numbers" : [1, 2, 3, 4, 5, 6.7] }'
tests << '{"float":[1.1,2.2,3.3],"fixnum":[1,2,3],"dictionary":{"key1":1,"key2":2}}'
tests << '{"hash_in_array":[{"key1":1,"key2":2},{"key1":3,"key2":4.5},{"key1":[11,22,33],"key2":[44,55,66]}]}'

jp = MyJson.new
tests.each_index do |ind|
  obj = jp.process_string(tests[ind])
  puts obj
end


puts "Done"


# require 'json'
#
# my_hash = {"hash_in_array" => [{"key1" => 1, "key2" => 2}, {"key1" => 1, "key2" => 2.5}, {"key1" => [1, 2, 3], "key2" => [4, 5, 6]}]}
# str =  JSON.generate(my_hash)
# puts str
