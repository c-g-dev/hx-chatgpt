# About

A simple wrapper for OpenAI's ChatGPT API completion HTTP endpoint. Usable on any target. An API key from OpenAI will be required, obviously.

# Example usage:

```haxe

var client = new ChatGPTClient(/*API KEY HERE*/, GPT_4);
var result = client.completion("This is a test, please acknowledge.");

switch result {
	case Success(result):{
		trace("success: " + result.content);
	}
	case Error(errorMessage): {
		trace("error: " + errorMessage);
	}
	case Promise(success, error): {
		success.listen((data) -> {
			trace("async success: " + data.content);
		});
		error.listen((data) -> {
			trace("async error: " + data);
		});
	}
}

```

`client.completion()` returns an enum value:

```haxe

enum ChatGPTClientResult {
    Success(result: ChatGPTClientPayload);
    Error(errorMessage: String);
    Promise(success: HxPromise<ChatGPTClientPayload>, error: HxPromise<String>);
}

```

On concurrent targets `client.completion()` will block and return `ChatGPTClientResult.Success` or `ChatGPTClientResult.Error`. If concurrency is not supported or `client.async == true` then `ChatGPTClientResult.Promise` will be returned, in which case data can be retrieved by `success.listen()`.

# Other features:

- `client.systemMessage` can be used to add a message with `role: "system"` to the request.
- `client.maxTokens` throttles tokens returned by the request.
- `client.enrichRequest` can be set to change the request JSON object before it is sent, thus allowing you to add custom params to the request.
- `ChatGPTClientPayload.content` returns the simple content of the result, but the full payload can be accessed through `ChatGPTClientPayload.fullTextPayload` or `ChatGPTClientPayload.fullJsonPayload`.