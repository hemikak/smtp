import ballerinax/java;

function newProperties() returns handle = @java:Constructor {
    class: "java.util.Properties"
} external;

function putStringProperty(handle receiver, handle key, handle value) returns handle = @java:Method {
    name: "put",
    class: "java.util.Properties"
} external;

function putIntegerProperty(handle receiver, handle key, int value) returns handle = @java:Method {
    name: "put",
    class: "java.util.Properties"
} external;