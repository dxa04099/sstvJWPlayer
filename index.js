import { Alert, Platform, NativeEventEmitter} from 'react-native';
import JWPlayer from './nativemodules/JWPlayer';

export default class JWPlayerModule {

  static jwPlayerIOSPLayListener:any;
  static jwPlayerIOSPauseListener:any;
  static jwPlayerIOSTimerListener:any;
  static jwPlayerIOSErrorListener:any;
  static jwPlayerIOSCloseListener:any;

  static doPlayVideo(videoOb:any):void {

		let videoUrl = videoOb.attributes.streamUrl;

    if (Platform.OS === 'ios') {

  			// VideoPlayer.showVideoPlayer(videoUrl);
  			if(JWPlayerModule.jwPlayerIOSPLayListener) JWPlayerModule.jwPlayerIOSPLayListener.remove();
  			const jwPlayerEventEmitter = new NativeEventEmitter(JWPlayer);
  			JWPlayerModule.jwPlayerIOSPLayListener = jwPlayerEventEmitter.addListener(
  				'jwOnPlay',
  				(playObject) => {
  						console.log("[JWPlayerModule] JWPlayer IOS playObject ", playObject);
  					}
  			);

  			if(JWPlayerModule.jwPlayerIOSTimerListener) JWPlayerModule.jwPlayerIOSTimerListener.remove();
  			JWPlayerModule.jwPlayerIOSTimerListener = jwPlayerEventEmitter.addListener(
  				'jwOnTime',
  				(time) => {
  					console.log("[JWPlayerModule] JWPlayer IOS time ",moment().format("HH:mm:ss"));
  				}
  			);

  			if(JWPlayerModule.jwPlayerIOSPauseListener) JWPlayerModule.jwPlayerIOSPauseListener.remove();
  			JWPlayerModule.jwPlayerIOSPauseListener = jwPlayerEventEmitter.addListener(
  				'jwOnPause',
  				(pauseObject) => {
  					console.log("[JWPlayerModule] JWPlayer IOS Pause ", pauseObject);
  				}
  			);

  			if(JWPlayerModule.jwPlayerIOSCompleteListener) JWPlayerModule.jwPlayerIOSCompleteListener.remove();
  			JWPlayerModule.jwPlayerIOSCompleteListener = jwPlayerEventEmitter.addListener(
  				'jwOnComplete',
  				(complete) => {
  					console.log("[JWPlayerModule] JWPlayer IOS Complete ", complete);
  				}
  			);

  			if(JWPlayerModule.jwPlayerIOSCloseListener) JWPlayerModule.jwPlayerIOSCloseListener.remove();
  			JWPlayerModule.jwPlayerIOSCloseListener = jwPlayerEventEmitter.addListener(
  				'jwOnClose',
  				(close) => {
  					console.log("[JWPlayerModule] JWPlayer IOS Close ", close);
  				}
  			);

  			if(JWPlayerModule.jwPlayerIOSErrorListener) JWPlayerModule.jwPlayerIOSErrorListener.remove();
  			JWPlayerModule.jwPlayerIOSErrorListener = jwPlayerEventEmitter.addListener(
  				'jwOnError',
  				(error) => {
  					console.log("[JWPlayerModule] JWPlayer IOS Error ",error);
  				}
  			);
        JWPlayer.PlayStream(videoUrl, 0);
    }else if (Platform.OS === 'android') {
      Alert.alert('', `[JWPlayerModule].playVideo Platform not yet supported ${Platform.OS}`);
    }else {
      Alert.alert('', `[JWPlayerModule].playVideo Platform not yet supported ${Platform.OS}`);
    }
  }
}
