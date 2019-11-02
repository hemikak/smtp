import ballerinax/java;

function getSessionInstance(handle properties, handle authenticator) returns handle = @java:Method {
    name: "getInstance",
    class: "javax.mail.Session",
    paramTypes: ["java.util.Properties", "javax.mail.Authenticator"]
} external;

function getSessionTransport(handle receiver, handle transport) returns handle|error = @java:Method {
    name: "getTransport",
    class: "javax.mail.Session",
    paramTypes: ["java.lang.String"]
} external;