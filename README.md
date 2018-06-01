
# react-native-sstv-jw-player

## Getting started

`$ npm install react-native-sstv-jw-player --save`

### Mostly automatic installation

`$ react-native link react-native-sstv-jw-player`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-sstv-jw-player` and add `RNSstvJwPlayer.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNSstvJwPlayer.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNSstvJwPlayerPackage;` to the imports at the top of the file
  - Add `new RNSstvJwPlayerPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-sstv-jw-player'
  	project(':react-native-sstv-jw-player').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-sstv-jw-player/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-sstv-jw-player')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNSstvJwPlayer.sln` in `node_modules/react-native-sstv-jw-player/windows/RNSstvJwPlayer.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Sstv.Jw.Player.RNSstvJwPlayer;` to the usings at the top of the file
  - Add `new RNSstvJwPlayerPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNSstvJwPlayer from 'react-native-sstv-jw-player';

// TODO: What to do with the module?
RNSstvJwPlayer;
```
  