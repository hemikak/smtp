// (C) Copyright 2019 Hemika Kodikara.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import ballerina/lang.'array as larrays;
import ballerinax/java;
import ballerinax/java.arrays as jarrays;

# Authenticator for the SMTP session.
# 
# + username - Username for the session.
# + password - Password for the session.
public type Authentictor record {|
    string username;
    string password;
|};

# Message to send on top of SMTP.
# 
# + 'from - Email from.
# + to - Receiver.
# + subject - Email subject.
# + content - Content of the email.
public type Message record {|
    string 'from;
    string[] to;
    string subject;
    string content;
|};

# SMTP session to send emails.
public type Session object {
    private handle jSession;
    private handle jTransport;

    # Initialize and connect to an SMTP library.
    # 
    # + host - SMTP host.
    # + port - SMTP port.
    # + authenticator - Authentication to give username and password.
    # + properties - Java properties for the SMTP connection.
    public function __init(string host, int port, Authentictor? authenticator = (), map<string>? properties = ()) returns error? {
        handle jProperties = newProperties();
        _ = putStringProperty(jProperties, java:fromString("mail.smtp.host"), java:fromString(host));
        _ = putIntegerProperty(jProperties, java:fromString("mail.smtp.port"), port);

        if (properties is map<string>) {
            properties.entries().forEach(function ([string, string] prop) {
                [string, string] [key, value] = prop;
                _ = putStringProperty(jProperties, java:fromString(key), java:fromString(value));
            });
        }

        handle jAuthenticator = java:createNull();
        if (authenticator is Authentictor) {
            jAuthenticator = newSMTPAuthenticator(java:fromString(authenticator.username), java:fromString(authenticator.password));
        }
        
        self.jSession = getSessionInstance(jProperties, jAuthenticator);
        self.jTransport = check getSessionTransport(self.jSession, java:fromString("smtp"));
        return connectTransport(self.jTransport);
    }

    # Send an email over the wire
    # 
    # + message - The email message.
    # + return - Error if occurrs.
    public function sendMessage(Message message) returns error? {
        handle jMimeMessage = newMimeMessage(self.jSession);

        // set message content
        check setMimeMessageContent(jMimeMessage, java:fromString(message.content), java:fromString("text/html; charset=utf-8"));

        // set sender
        check setMimeMessageFrom(jMimeMessage, check newInternetAddress(java:fromString(message.'from)));

        // set reply to
        handle replyToArray = jarrays:newInstance(check java:getClass("javax.mail.internet.InternetAddress"), 1);
        jarrays:set(replyToArray, 0, check newInternetAddress(java:fromString(message.'from)));
        check setMimeMessageReplyTo(jMimeMessage, replyToArray);

        // set subject
        check setMimeMessageSubject(jMimeMessage, java:fromString(message.subject), java:fromString("UTF-8"));

        // set date
        check setMimeMessageSentDate(jMimeMessage, newDate());

        // set to
        handle recipientArray = jarrays:newInstance(check java:getClass("javax.mail.internet.InternetAddress"), message.to.length());
        foreach [int, string] [index, address] in larrays:enumerate(message.to) {
            jarrays:set(recipientArray, index, check newInternetAddress(java:fromString(address)));
        }
        check setMimeMessageRecipients(jMimeMessage, messageTypeTo(), recipientArray);

        // send message
        check sendTransport(jMimeMessage);
    }
};
