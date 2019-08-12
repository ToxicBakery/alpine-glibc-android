FROM toxicbakery/alpine-glibc-android

ARG ANDROID_NDK_TOOLS=r18b

# NDK
RUN wget -q -O android-ndk.zip https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_TOOLS}-linux-x86_64.zip \
 && unzip -qo android-ndk.zip \
 && rm android-ndk.zip
