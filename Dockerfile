FROM ballerina/ballerina:1.0.1

COPY libs/smtp-authenticator-1.0.0.jar libs/smtp-authenticator-1.0.0.jar
COPY src/smtp src/smtp
COPY Ballerina.lock Ballerina.lock
COPY Ballerina.toml Ballerina.toml

RUN ballerina build -c --skip-tests smtp
