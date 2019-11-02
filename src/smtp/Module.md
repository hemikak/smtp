SMTP Library to send Emails.

## Module Overview
A ballerina library that allows you to send email via SMTP protocol. This module uses `javax.mail` java package to send emails.

## Sample
```ballerina
Authentictor auth = {
    username: "<fill>",
    password: "<fill>"
};
map<string> props = {
    "mail.smtp.auth": "true"
};
Session smtpSession = checkpanic new("smtp.mailtrap.io", 2525, authenticator = auth, properties = props);

Message msg = {
    'from: "bartsimpsons@mail.com",
    to: "lisasimpsons@mail.com",
    subject: "WHOA!",
    content: "Hello World!"
};
checkpanic smtpSession.sendMessage(msg);
```

