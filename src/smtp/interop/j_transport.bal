import ballerinax/java;

function connectTransport(handle receiver) returns error? = @java:Method {
    name: "connect",
    class: "javax.mail.Transport"
} external;

function sendTransport(handle message) returns error? = @java:Method {
    name: "send",
    class: "javax.mail.Transport",
    paramTypes: ["javax.mail.Message"]
} external;