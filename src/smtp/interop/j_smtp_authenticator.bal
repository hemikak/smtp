import ballerinax/java;

function newSMTPAuthenticator(handle username, handle password) returns handle = @java:Constructor {
    class: "org.hemikak.smtp.SMTPAuthenticator",
    paramTypes: ["java.lang.String", "java.lang.String"]
} external;
