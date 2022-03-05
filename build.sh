docker build . -t toxicbakery/alpine-glibc-android:release-$1
docker push toxicbakery/alpine-glibc-android:release-$1

cd ndk
docker build . -t toxicbakery/alpine-glibc-android:release-ndk-$1
docker push toxicbakery/alpine-glibc-android:release-ndk-$1

