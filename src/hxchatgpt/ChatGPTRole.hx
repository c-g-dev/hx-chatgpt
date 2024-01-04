package hxchatgpt;

enum abstract ChatGPTRole(String) to String from String {
    var System = "system";
    var User = "user";
}