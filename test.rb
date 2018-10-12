require_relative 'myJson.rb'
require 'json'

tests = []
# strings
tests << '{ "first_name" : "Sammy", "last_name" : "Dickens"}'
tests << '{"first_name":"Sammy","last_name":"Dickens"}'

# bool
tests << '{ "first_name" : "Sammy", "last_name" : "Dickens",  "online" : true }'
tests << '{ "first_name" : "Sammy", "last_name" : "Dickens",  "online" : true}'

# Fixnum and Float
tests << '{"string":"goodbye","fixnum":6,"float": 48.9}'
tests << '{"string":"goodbye","fixnum":6,"float":48.9 }'
tests << '{"string":"goodbye","float":48.9, "fixnum":6 }'
tests << '{"string":"goodbye","float":48.9, "fixnum":6}'

# escape character
tests << '{ "first\"_name" : "Sammy"}'
tests << '{ "first\\_name" : "Sammy"}'
tests << '{ "first\a_name" : "Sammy"}'
tests << '{ "first\b_name" : "Sammy"}'
tests << '{ "first\r_name" : "Sammy"}'
tests << '{ "first\n_name" : "Sammy"}'
tests << '{ "first\s_name" : "Sammy"}'
tests << '{ "first\t_name" : "Sammy"}'

# nested Hash
tests << '{"string":"goodbye","numbers":{"fixnum":6,"float":48.9}}'
tests << '{"string":"goodbye","numbers":{ "fixnum" : 6, "float" : 48.9 } }'

# nested Array
tests << '{"string":"goodbye","numbers":[1,2,3,4,5,6.7]}'
tests << '{"string" : "goodbye" , "numbers" : [1, 2, 3, 4, 5, 6.7] }'
tests << '{"float":[1.1,2.2,3.3],"fixnum":[1,2,3],"dictionary":{"key1":1,"key2":2}}'
tests << '{"hash_in_array":[{"key1":1,"key2":2},{"key1":3,"key2":4.5},{"key1":[11,22,33],"key2":[44,55,66]}]}'

# Latin1 characters
tests << '{ "title" : "The Howard Stern Show–XL"}'
tests << '{ "title" : "ÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâã"}'
tests << '{"favorites_list":[{"favorite_primary_text":"The Howard Stern Show–XL"},{"favorite_primary_text":"ÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâã"}],"type":"response","name":"get_favorites_list","result":"success"}'

mj = MyJson.new
tests.each_index do |ind|
  obj = mj.process_string(tests[ind])
  puts obj
end


puts "Done"


# require 'json'
# my_hash = {"text"=>"text to check \" escape sequence"}
# str =  JSON.generate(my_hash)
# puts str
