import ballerinax/java;
import ballerina/lang.'string as lstring;

public type Authentictor record {|
    string username;
    string password;
|};

public type Message record {|
    string 'from;
    string[] to;
    string subject;
    string content;
|};

public type Session object {
    private handle jSession;
    function __init(string host, int port, Authentictor? authenticator = (), string? password = ()) returns error? {
        handle jProperties = newProperties();
        handle jStringHost = java:fromString(host);
        _ = putStringProperty(jProperties, java:fromString("mail.smtp.host"), jStringHost);
        _ = putIntegerProperty(jProperties, java:fromString("mail.smtp.port"), port);

        handle jAuthenticator = java:createNull();
        if (authenticator is Authentictor) {
            jAuthenticator = newSMTPAuthenticator(java:fromString(authenticator.username), java:fromString(authenticator.password));
        }
        
        self.jSession = getSessionInstance(jProperties, jAuthenticator);
        handle jTransport = check getSessionTransport(self.jSession, java:fromString("smtp"));
        return connectTransport(jTransport);
    }

    function sendMessage(Message message) returns error? {
        handle jMimeMessage = newMimeMessage(self.jSession);
        check setMimeMessageContent(jMimeMessage, java:fromString(message.content), java:fromString("text/html; charset=utf-8"));
        check setMimeMessageFrom(jMimeMessage, check newInternetAddress(java:fromString(message.'from)));
        check setMimeMessageReplyTo(jMimeMessage, check parseInternetAddress(java:fromString(message.'from), false));
        check setMimeMessageSubject(jMimeMessage, java:fromString(message.subject), java:fromString("UTF-8"));
        check setMimeMessageSentDate(jMimeMessage, newDate());
        string toAddresses = lstring:'join(",", ...message.to);
        check setMimeMessageRecipients(jMimeMessage, messageTypeTo(), check parseInternetAddress(java:fromString(toAddresses), false));
        check sendTransport(jMimeMessage);
    }
};