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

import ballerina/test;

// Refer - https://blog.mailtrap.io/sending-email-using-java/
@test:Config {}
public function sendEmail() {
    Authentictor auth = {
        username: "<fill>",
        password: "<fill>"
    };
    map<string> props = {
        "mail.smtp.auth": "true"
    };
    Session smtpSession = checkpanic new("smtp.mailtrap.io", 2525, authenticator = auth, properties = props);

    Message msg = {
        'from: "0efcb495f9-70ca25@inbox.mailtrap.io",
        to: ["foo.bar@gmail.com"],
        subject: "Test Mail",
        content: "Hello"
    };
    checkpanic smtpSession.sendMessage(msg);
}
