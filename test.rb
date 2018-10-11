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

jp = MyJson.new
tests.each_index do |ind|
  obj = jp.process_string(tests[ind])
  puts obj
end



# require 'json'
#
# my_hash = {"string" => "goo\"dbye", "fixnum" => 6, "float" => 48.9}
# str =  JSON.generate(my_hash)
# puts str
