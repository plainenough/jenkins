FROM openjdk:8-jdk-stretch

ENV LINK_ANDROID_SDK=https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    LANG=en_US.UTF-8 \
    TERM=xterm-256color \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    GRADLE_VERSION=4.1 \
    GRADLE_HOME="/opt/gradle-4.1/bin" \
    ANDROID_HOME="/opt/android-sdk-linux" \
    PATH="$PATH:/usr/local/rvm/bin:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools/bin:/opt/android-sdk-linux/emulator:/opt/gradle-4.1/bin"

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq libstdc++6:i386 zlib1g:i386 libncurses5:i386 git mercurial bash curl ca-certificates unzip git-extras zip software-properties-common apt-transport-https locales --no-install-recommends && \
    apt-get clean && \
    locale-gen en_US.UTF-8

# Install Android SDK
RUN curl -sSL $LINK_ANDROID_SDK > /tmp/android-sdk-linux.zip && \
    unzip /tmp/android-sdk-linux.zip -d /opt/android-sdk-linux/ && \
    rm /tmp/android-sdk-linux.zip && \
    sdkmanager --update && \
    yes | sdkmanager --licenses && \
    sdkmanager \
      tools \
      platform-tools \
      "platforms;android-28" \
      "build-tools;28.0.3" \
      --verbose && \
    unset ANDROID_NDK_HOME && \
    # Unfilter devices
    curl -sSL -o /root/.android/adb_usb.ini https://raw.githubusercontent.com/apkudo/adbusbini/master/adb_usb.ini

# Install Gradle
RUN cd /opt && \
    curl -fl -sSL https://downloads.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip -o gradle-bin.zip && \
    unzip -q "gradle-bin.zip" && \
    rm "gradle-bin.zip" && \
    mkdir -p ~/.gradle && \
    echo "org.gradle.daemon=false\norg.gradle.parallel=true\norg.gradle.configureondemand=true" > ~/.gradle/gradle.properties

USER root

RUN mkdir /root/android && cd /root/android/

CMD pwd && tail -f /etc/bash.bashrc
