import ballerinax/java;

function newDate() returns handle = @java:Constructor {
    class: "java.util.Date"
} external;