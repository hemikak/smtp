import ballerinax/java;

function newMimeMessage(handle session) returns handle = @java:Constructor {
    class: "javax.mail.internet.MimeMessage",
    paramTypes: ["javax.mail.Session"]
} external;

function setMimeMessageContent(handle receiver, handle content, handle contentType) returns error? = @java:Method {
    name: "setContent",
    class: "javax.mail.internet.MimeMessage",
    paramTypes: ["java.lang.Object", "java.lang.String"]
} external;

function setMimeMessageFrom(handle receiver, handle internetAddress) returns error? = @java:Method {
    name: "setFrom",
    class: "javax.mail.internet.MimeMessage",
    paramTypes: ["javax.mail.Address"]
} external;

function setMimeMessageReplyTo(handle receiver, handle internetAddresses) returns error? = @java:Method {
    name: "setReplyTo",
    class: "javax.mail.internet.MimeMessage",
    paramTypes: [{ class: "javax.mail.Address", dimensions: 1 }]
} external;

function setMimeMessageSubject(handle receiver, handle subject, handle charset) returns error? = @java:Method {
    name: "setSubject",
    class: "javax.mail.internet.MimeMessage",
    paramTypes: ["java.lang.String", "java.lang.String"]
} external;

function setMimeMessageSentDate(handle receiver, handle date) returns error? = @java:Method {
    name: "setSentDate",
    class: "javax.mail.internet.MimeMessage",
    paramTypes: ["java.util.Date"]
} external;

public function messageTypeTo() returns handle = @java:FieldGet {
    name: "TO",
    class: "javax.mail.Message.RecipientType"
} external;

function setMimeMessageRecipients(handle receiver, handle reciepientType, handle addresses) returns error? = @java:Method {
    name: "setRecipients",
    class: "javax.mail.internet.MimeMessage",
    paramTypes: ["javax.mail.Message.RecipientType", { class: "javax.mail.Address", dimensions: 1 }]
} external;

