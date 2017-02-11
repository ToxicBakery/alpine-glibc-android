FROM frolvlad/alpine-glibc:alpine-3.5

#################################
# Install openjdk 8
#################################
ENV LANG C.UTF-8
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u121
ENV JAVA_ALPINE_VERSION 8.121.13-r0

RUN set -x \
	&& apk add --no-cache \
		openjdk8="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]
#################################

ARG ANDROID_TARGET_SDK=25
ARG ANDROID_BUILD_TOOLS=25.0.2
ARG ANDROID_SDK_TOOLS=25.2.3

ENV ANDROID_HOME=${PWD}/android-sdk-linux
ENV PATH=${PATH}:${ANDROID_HOME}/platform-tools

RUN wget -q -O android-sdk.zip http://dl.google.com/android/repository/tools_r${ANDROID_SDK_TOOLS}-linux.zip && \
 mkdir android-sdk-linux && \
 unzip -qo android-sdk.zip -d android-sdk-linux && \
 rm android-sdk.zip && \
 mkdir -p ~/.gradle && \
 echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties && \
 echo y | ${ANDROID_HOME}/tools/android --silent update sdk --no-ui --no-https --all --filter android-${ANDROID_TARGET_SDK} && \
 echo y | ${ANDROID_HOME}/tools/android --silent update sdk --no-ui --no-https --all --filter platform-tools && \
 echo y | ${ANDROID_HOME}/tools/android --silent update sdk --no-ui --no-https --all --filter build-tools-${ANDROID_BUILD_TOOLS} && \
 mkdir -p ${ANDROID_HOME}/licenses/ && \
 echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > ${ANDROID_HOME}/licenses/android-sdk-license && \
 echo "84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license
