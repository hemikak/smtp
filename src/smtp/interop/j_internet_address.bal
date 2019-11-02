import ballerinax/java;

function newInternetAddress(handle address) returns handle|error = @java:Constructor {
    class: "javax.mail.internet.InternetAddress",
    paramTypes: ["java.lang.String"]
} external;

function parseInternetAddress(handle addressList, boolean strict) returns handle|error = @java:Method {
    name: "parse",
    class: "javax.mail.internet.InternetAddress",
    paramTypes: ["java.lang.String", "boolean"]
} external;