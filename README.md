ElasticCF
=========

#ElasticCF Documention
From: https://github.com/Prefinem/RedBeanCF

Coldfusion Component to and get/set/upsert/delete for Elastic Search

##Intro

This is a small library to use Elastic Search as a caching mechanism

##Version
v.0.1

##Licensce

Licensed under MIT License
http://opensource.org/licenses/MIT

##Examples
Here is some basic examples

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

##ElasticCF Methods

###setup
Accepts: Host (defaults to localhost), Port (defaults to 9200)
Returns: void
Examples:

    var ES = new es();
    ES.setup("localhost","9200");

###get
Accepts: index, type, id
Returns: structure
Examples:

    ES.get('index','user', 1);

###put
Accepts: index, type, id, data struct
Returns: boolean
Examples:

    ES.put('index','user', 1, user);

###delete
Accepts: index, type, id
Returns: void
Examples:

    ES.delete('index','user', 1);

###upsert
Accepts: index, type, id, data struct
Returns: void
Examples:

    ES.upsert('index','user', 1, user);

##TODO

###Search
Allow ElasticCF to search indexes