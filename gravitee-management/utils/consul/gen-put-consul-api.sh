cat  keys | awk '{print "curl --request PUT --data 1 http://172.20.0.2:8500/v1/kv/develop/bu"$0 }' |sed 's/,//g' | sed 's/\"//g' >  put-consul-api 

