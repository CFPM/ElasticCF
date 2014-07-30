ElasticCF
=========

Coldfusion Component to and get/set/upsert/delete for Elastic Search

##Examples

###Lets load this thing up
setup() takes a host and port, defaults to localhost and 9200 respectively

    var ES = new es();
    es.setup("localhost","9200");

###Lets add some data.
set() takes an index, type, id and data struct

    var user = {};
    user.id = 1;
    user.name = 'William';
    user.email = 'william@xondesigns.com';
    ES.put('index','user', user.id, user);
    
###Lets change that data
upsert() takes an index, type, id and data struct

    var user = {};
    user.name = "Billiam";
    ES.upsert('index', 'user', 1, user);
    
###Lets get that data
get() takes an index, type and id

    var response = ES.get('index', 'user', 1);
    
###Lets delete that data
delete() takes an index, type and id

    ES.delete('index', 'user', 1);
