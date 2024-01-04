package hxchatgpt;
import haxe.Json;

class ChatGPTClient {
    public static final CHATGPT_API_URL = "https://api.openai.com/v1/chat/completions";

    public var openAIKey: String;
    public var url: String;
    public var model: ChatGPTModel;
    public var systemMessage: String = null;
    public var maxTokens: Int = 1000;
    public var async: Bool = false;

    public function new(key: String, ?model: ChatGPTModel = GPT_3_5_TURBO) {
        this.url = CHATGPT_API_URL;
        this.openAIKey = key;
        this.model = model;
    }

    public function completion(message: String): ChatGPTClientResult {
        var http = new haxe.Http(CHATGPT_API_URL);
        http.addHeader("Content-Type", "application/json");
        http.addHeader("Authorization", 'Bearer ${openAIKey}');

        var req = new ChatGPTClientRequest(model, maxTokens);
        if(systemMessage != null){
            req.addMessage(System, systemMessage);
        }
        req.addMessage(User, message);
        
        var jsob = req.toJson();
        jsob = enrichRequest(jsob);
        http.setPostData(Json.stringify(jsob));

        #if (target.threaded)
        if(!async){
            var lock = new sys.thread.Lock();
            var result: ChatGPTClientResult = null;
            http.onData = (data) -> {
                result = Success(new ChatGPTClientPayload(data));
                lock.release();
            }
            http.onError = (data) -> {
                result = Error(data);
                lock.release();
            }
            http.request(true);
            lock.wait();
            return result;
        }
        else{
        #end
            var successP = new HxPromise<ChatGPTClientPayload>();
            var errorP = new HxPromise<String>();
            http.onData = (data) -> {
                successP.fulfill(new ChatGPTClientPayload(data));
            }
            http.onError = (data) -> {
                errorP.fulfill(data);
            }
            http.request(true);
            return Promise(successP, errorP);
        #if (target.threaded)
        }
        #end
        
    } 


    public dynamic function enrichRequest(jsonObj: Dynamic): Dynamic {
        return jsonObj;
    }
}