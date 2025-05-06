#!/bin/zsh

PROJECT=specky-repo
PACKAGE_NAME="org.specky"

spring boot start \
    --path $PROJECT \
    --project gradle-project \
    --language java \
    --boot-version "3.4.4" \
    --version "0.0.1-SNAPSHOT" \
    --group $PACKAGE_NAME \
    --artifact $PROJECT \
    --name "Specky Repo" \
    --description "Specky Component Repository" \
    --package-name $PACKAGE_NAME \
    --dependencies "web,data-jpa,h2,devtools,lombok" \
    --packaging jar \
    --java-version 21
