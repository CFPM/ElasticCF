/*
 * Any changes should be made and pushed to here: https://github.com/Prefinem/ElasticCF
 * Author: William Giles
 * License: MIT http://opensource.org/licenses/MIT
 */

component singleton {

	public function init(){
		return this;
	}

	public function setup(string host="localhost", string port="9200"){
		variables.host = arguments.host;
		variables.port = arguments.port;
	}

	public function get(string index='', string type='', string id=''){
		var url = buildURL(argumentCollection=arguments);
		var response = curl("get",url);
		return parse(response);
	}

	public function put(string index='', string type='', string id='', struct data = {}){
		var url = buildURL(argumentCollection=arguments);
		var body = serializeJSON(data);
		var response = curl("post",url,body);
		return parse(response);
	}

	public function delete(string index='', string type='', string id=''){
		var url = buildURL(argumentCollection=arguments);
		var response = curl("delete",url);
		return parse(response);
	}

	public function upsert(string index='', string type='', string id='', struct data = {}){
		var url = buildURL(argumentCollection=arguments);
		url = url & '/_update';

		var temp = {};
		temp["doc"] = data;
		temp["doc_as_upsert"] = true;
		var body = serializeJSON(temp);

		var response = curl("post",url,body);
		return parse(response);
	}

	/*
	 * Private functions
	 */

	private function parse(data){
		var response = deserializeJSON(data,false);
		if(structKeyExists(response,"_source")){
			return response._source;
		}else if(structKeyExists(response,"created")){
			return response.created;
		}else if(structKeyExists(response,"found")){
			return response.found;
		}
		return response;
	}

	private function getBaseURL(){
		return 'http://' & variables.host & ':' & variables.port;
	}

	private function buildURL(string index='', string type='', string id=''){
		var url = getBaseURL();

		if(len(trim(index)))
			url = url & '/' & index;
		if(len(trim(type)))
			url = url & '/' & type;
		if(len(trim(id)))
			url = url & '/' & id;

		return url;
	}

	private function curl(method,url,body="",params={}){
		var httpService = new http(timeout = "5");
		httpService.setCharset("utf-8");
		httpService.setMethod(method);
		httpService.setURL(url);
		httpService.addParam(type="header",name="Content-Type", value="application/json");
		if(len(trim(body))){
			httpService.addParam(type="body", value="#body#");
		}
		if(!StructIsEmpty(arguments.params)){
			for(var key in arguments.params){
				 httpService.addParam(type="formfield",name=key,value="#arguments.params[key]#"); 
			}
		}
		var response = httpService.send();

		if(!Find('application/json',response.getPrefix().Mimetype)){
			var data = '{"status":"error","message":"#response.getPrefix().Filecontent#"}';
		}else{
			var data = response.getPrefix().Filecontent.toString();
			response.getPrefix().Filecontent.close();
		}
		
		httpService.clear();
		return data;
	}

}
