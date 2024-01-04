package hxchatgpt;

import haxe.Json;

class ChatGPTClientRequest {
	var model:ChatGPTModel;
	var maxTokens: Int;
	var messages:Array<{role:String, content:String}> = [];

	public function new(model:ChatGPTModel, maxTokens: Int) {
		this.model = model;
		this.maxTokens = maxTokens;
	}

    public function addMessage(roleArg:ChatGPTRole, contentArg:String): Void {
        messages.push({
            role: roleArg,
            content: contentArg
        });
    }

	public function toJson():Dynamic {
		var jsonObj: {model: String, max_tokens: Int, messages:Array<{role:String, content:String}>} = {
			model: this.model,
			max_tokens: this.maxTokens,
			messages: this.messages
		}
		return jsonObj;
	}
}
