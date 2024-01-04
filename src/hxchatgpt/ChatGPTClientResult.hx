package hxchatgpt;

enum ChatGPTClientResult {
    Success(result: ChatGPTClientPayload);
    Error(errorMessage: String);
    Promise(success: HxPromise<ChatGPTClientPayload>, error: HxPromise<String>);
}