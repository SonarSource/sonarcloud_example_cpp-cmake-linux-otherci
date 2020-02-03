# C++ example project scanned on SonarCloud using any CI

[![Build status](https://travis-ci.org/SonarSource/sonarcloud_example_cpp-cmake-linux-otherci.svg?branch=master)](https://travis-ci.org/SonarSource/sonarcloud_example_cpp-cmake-linux-otherci)[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=sonarcloud_example_cpp-cmake-linux-otherci&metric=alert_status)](https://sonarcloud.io/dashboard?id=sonarcloud_example_cpp-cmake-linux-otherci)

#### This project is analysed on [SonarCloud](https://sonarcloud.io)!

The build.sh script demonstrates how to run an analysis on a C++ project build.
Note that for security reasons, the environment variable SONAR_TOKEN is defined in the environement through the CI. It should not be made public.
Travis is used for demonstration purpose as any CI could be used to run the build.sh script.

You can take a look at the script
[buid.sh](https://github.com/SonarSource/sonarcloud_example_cpp-cmake-linux-otherci/blob/master/build.sh)
of this project to see it in practice.

## Links
- [Documentation of the C/C++/Objective-C plugin and its with Build Wrapper](http://docs.sonarqube.org/x/pwAv)
