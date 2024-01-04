package hxchatgpt;

import haxe.Json;

class ChatGPTClientPayload {
    public var fullTextPayload: String;
    public var fullJsonPayload: Dynamic;
    public var content: String;

    public function new(textPayload: String) {
        this.fullTextPayload = textPayload;
        this.fullJsonPayload = Json.parse(fullTextPayload);
        this.content = fullJsonPayload.choices[0].message.content;
    }
}