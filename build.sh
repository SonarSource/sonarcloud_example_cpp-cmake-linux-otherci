#!/bin/bash

# use only one of SonarQube or SonarCloud

# Configuration for SonarQube
#SONAR_HOST_URL="http://localhost:9000" # URL of the SonarQube server
#SONAR_TOKEN=f5f56032a938d29cf76d78de33991eb8c273a0ea # access token from SonarQube projet creation page -Dsonar.login=XXXX
#SONAR_PROJECT_KEY=sonar_scanner_example # project name from SonarQube projet creation page -Dsonar.projectKey=XXXX
#SONAR_PROJECT_NAME=sonar_scanner_example # project name from SonarName projet creation page -Dsonar.projectName=XXXX

# Configuration for SonarCloud
#SONAR_TOKEN= # access token from SonarCloud projet creation page -Dsonar.login=XXXX: here it is defined in the environment through the CI
SONAR_PROJECT_KEY=sonarcloud_example_cpp-cmake-linux-otherci # project name from SonarCloud projet creation page -Dsonar.projectKey=XXXX
SONAR_PROJECT_NAME=sonarcloud_example_cpp-cmake-linux-otherci # project name from SonarCloud projet creation page -Dsonar.projectName=XXXX
SONAR_ORGANIZATION=sonarcloud # organization name from SonarCloud projet creation page -Dsonar.organization=ZZZZ

# Set default to SONAR_HOST_URL in not provided
SONAR_HOST_URL=${SONAR_HOST_URL:-https://sonarcloud.io}

mkdir $HOME/.sonar
export SONAR_SCANNER_VERSION=4.2.0.1873
export SONAR_SCANNER_HOME=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-linux

# download sonar-scanner
curl -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip 
unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
export PATH=$SONAR_SCANNER_HOME/bin:$PATH
export SONAR_SCANNER_OPTS="-server"

# download build-wrapper
curl -sSLo $HOME/.sonar/build-wrapper-linux-x86.zip https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
unzip -o $HOME/.sonar/build-wrapper-linux-x86.zip -d $HOME/.sonar/
export PATH=$HOME/.sonar/build-wrapper-linux-x86:$PATH

# Setup the build system
rm -rf build
mkdir build
cd build
cmake ..
cd ..

# Build inside the build-wrapper
build-wrapper-linux-x86-64 --out-dir build_wrapper_output_directory cmake --build build/ --config Release

# Run sonar scanner (here, arguments are passed through the command line but most of them can be written in the sonar-project.properties file)
[[ -v SONAR_TOKEN ]] && SONAR_TOKEN_CMD_ARG="-Dsonar.login=${SONAR_TOKEN}"
[[ -v SONAR_ORGANIZATION ]] && SONAR_ORGANIZATION_CMD_ARG="-Dsonar.organization=${SONAR_ORGANIZATION}"
[[ -v SONAR_PROJECT_NAME ]] && SONAR_PROJECT_NAME_CMD_ARG="-Dsonar.projectName=${SONAR_PROJECT_NAME}"
SONAR_OTHER_ARGS="-Dsonar.projectVersion=1.0 -Dsonar.sources=src -Dsonar.cfamily.build-wrapper-output=build_wrapper_output_directory -Dsonar.sourceEncoding=UTF-8"
sonar-scanner -Dsonar.host.url="${SONAR_HOST_URL}" -Dsonar.projectKey=${SONAR_PROJECT_KEY} ${SONAR_OTHER_ARGS} ${SONAR_PROJECT_NAME_CMD_ARG} ${SONAR_TOKEN_CMD_ARG} ${SONAR_ORGANIZATION_CMD_ARG}

