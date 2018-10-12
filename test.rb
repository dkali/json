require_relative 'myJson.rb'
require 'json'

tests = []
# strings
tests << '{ "first_name" : "Sammy", "last_name" : "Dickens"}'
tests << '{"first_name":"Sammy","last_name":"Dickens","nick name":"QNX"}'

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

# empty value
tests << '{ "title" : ""}'
tests << '{"channel_list":[{"channel_name":"chan_1","channel_desc":"chan_1_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_2","channel_desc":"chan_2_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_3","channel_desc":"chan_3_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_4","channel_desc":"chan_4_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_5","channel_desc":"chan_5_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_6","channel_desc":"chan_6_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_7","channel_desc":"chan_7_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_8","channel_desc":"chan_8_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_9","channel_desc":"chan_9_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_10","channel_desc":"chan_10_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_11","channel_desc":"chan_11_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_12","channel_desc":"chan_12_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_13","channel_desc":"chan_13_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_14","channel_desc":"chan_14_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_15","channel_desc":"chan_15_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_16","channel_desc":"chan_16_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_17","channel_desc":"chan_17_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_18","channel_desc":"chan_18_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_19","channel_desc":"chan_19_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_20","channel_desc":"chan_20_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_21","channel_desc":"chan_21_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_22","channel_desc":"chan_22_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_23","channel_desc":"chan_23_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_24","channel_desc":"chan_24_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_25","channel_desc":"chan_25_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_26","channel_desc":"chan_26_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_27","channel_desc":"chan_27_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_28","channel_desc":"chan_28_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_29","channel_desc":"chan_29_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""},{"channel_name":"chan_30","channel_desc":"chan_30_description","channel_status":"subscribed","contextual_banner":"new channel","team_data":""}],"type":"response","name":"get_channel_list","result":"success"}'

mj = MyJson.new
tests.each_index do |ind|
  obj = mj.process_string(tests[ind])
  puts obj
end

puts 'Done'

# require 'json'
# my_hash = {"text"=>"text to check \" escape sequence"}
# str =  JSON.generate(my_hash)
# puts str
