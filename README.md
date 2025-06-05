# Deprecated
This plugin is deprecated and `7.1` is the last release. We kindly recommend migrating to our new plugin `@regulaforensics/face-sdk`:
* [github](https://github.com/regulaforensics/npm-face-sdk)
* [npmjs](https://www.npmjs.com/package/@regulaforensics/face-sdk)

## Regula Face API (React Native version)
Face API is a framework that is used for face matching, recognition and liveness detection.

## Contents
* [How to build the demo application](#how-to-build-the-demo-application)
* [How to use offine match](#how-to-use-offine-match)
* [Documentation](#documentation)
* [Additional information](#additional-information)

## How to build the demo application
1. Download or the clone current repository using the command `git clone https://github.com/regulaforensics/react-native-face-api.git`.
2. Run the following commands within the root directory:
```bash
$ cd example
$ npm install
$ cd ios
$ pod install
```

**Note**: make sure that Metro Bundler is running when you run your app. Otherwise, run `npx react-native start` command. If it fails to start, run `git init` from Project root, then `npx react-native start`.

3. Android:
  * Run `npx react-native run-android` inside `example` folder - this is just one way to run the app. You can also run it directly from within Android Studio.

**Note**: if the running failed with the following error `Error: spawn ./gradlew EACCES`, try to run the following command `chmod +x gradlew` within the `example/android` directory.

4. iOS:
  * Run `npx react-native run-ios` inside `example` folder - this is just one way to run the app. You can also run it directly from within Xcode.

## How to use offline match
1. Place a license that supports offline match at `android/app/src/main/assets/regula.license` and `ios/license/regula.license`.
2. Change android and iOS bundle id if required by your license with the following commands(replace `ANDROID_ID` and `IOS_ID` with actual ids):
```bash
git init
npx react-native-rename@latest "FaceApi" --androidBundleID "ANDROID_ID" --iosBundleID "IOS_ID" --skipGitStatusCheck
```
3. Change core with the following commands:
```bash
npm uninstall @regulaforensics/react-native-face-core-basic
npm install @regulaforensics/react-native-face-core-match
```
4. Turn off the internet and run the app.

## Documentation
You can find documentation on API [here](https://docs.regulaforensics.com/develop/face-sdk/mobile).

## Additional information
If you have any technical questions, feel free to [contact](mailto:support@regulaforensics.com) us or create issues [here](https://github.com/regulaforensics/react-native-face-api/issues).
