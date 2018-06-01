import { Alert, Platform} from 'react-native';
import JWPlayer from '../nativemodules/JWPlayer';

export default class JWPlayer {

  static jwPlayerIOSPLayListener:any;
  static jwPlayerIOSPauseListener:any;
  static jwPlayerIOSTimerListener:any;
  static jwPlayerIOSErrorListener:any;
  static jwPlayerIOSCloseListener:any;

  static doPlayVideo(videoOb:any):void {

		let videoUrl = videoOb.attributes.streamUrl;

    if (Platform.OS === 'ios') {

  			// VideoPlayer.showVideoPlayer(videoUrl);
  			if(Utils.jwPlayerIOSPLayListener) Utils.jwPlayerIOSPLayListener.remove();
  			const jwPlayerEventEmitter = new NativeEventEmitter(JWPlayer);
  			Utils.jwPlayerIOSPLayListener = jwPlayerEventEmitter.addListener(
  				'jwOnPlay',
  				(playObject) => {
  						console.log("[Utils] JWPlayer IOS playObject ", playObject);
  					}
  			);

  			if(Utils.jwPlayerIOSTimerListener) Utils.jwPlayerIOSTimerListener.remove();
  			Utils.jwPlayerIOSTimerListener = jwPlayerEventEmitter.addListener(
  				'jwOnTime',
  				(time) => {
  					console.log("[Utils] JWPlayer IOS time ",moment().format("HH:mm:ss"));
  				}
  			);

  			if(Utils.jwPlayerIOSPauseListener) Utils.jwPlayerIOSPauseListener.remove();
  			Utils.jwPlayerIOSPauseListener = jwPlayerEventEmitter.addListener(
  				'jwOnPause',
  				(pauseObject) => {
  					console.log("[Utils] JWPlayer IOS Pause ", pauseObject);
  				}
  			);

  			if(Utils.jwPlayerIOSCompleteListener) Utils.jwPlayerIOSCompleteListener.remove();
  			Utils.jwPlayerIOSCompleteListener = jwPlayerEventEmitter.addListener(
  				'jwOnComplete',
  				(complete) => {
  					console.log("[Utils] JWPlayer IOS Complete ", complete);
  				}
  			);

  			if(Utils.jwPlayerIOSCloseListener) Utils.jwPlayerIOSCloseListener.remove();
  			Utils.jwPlayerIOSCloseListener = jwPlayerEventEmitter.addListener(
  				'jwOnClose',
  				(close) => {
  					console.log("[Utils] JWPlayer IOS Close ", close);
  				}
  			);

  			if(Utils.jwPlayerIOSErrorListener) Utils.jwPlayerIOSErrorListener.remove();
  			Utils.jwPlayerIOSErrorListener = jwPlayerEventEmitter.addListener(
  				'jwOnError',
  				(error) => {
  					console.log("[Utils] JWPlayer IOS Error ",error);
  				}
  			);
        JWPlayer.PlayStream(videoUrl, 0);
    }else if (Platform.OS === 'android') {
      Alert.alert('', `[Utils].playVideo Platform not yet supported ${Platform.OS}`);
    }else {
      Alert.alert('', `[Utils].playVideo Platform not yet supported ${Platform.OS}`);
    }
  }
}
