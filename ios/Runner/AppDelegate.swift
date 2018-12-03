import UIKit
import Flutter
import SafariServices

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SFSafariViewControllerDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
        let webViewChannel = FlutterMethodChannel.init(name: "ru.luharitrip.luharitrip/nativeInteraction",
                                                       binaryMessenger: controller);


        webViewChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if(call.method=="openWebView"){
                if #available(iOS 9.0, *){
                    let safariVC = SFSafariViewController(url: NSURL(string: call.arguments as! String)! as URL)
                    controller.present(safariVC, animated: true, completion: nil)
                    safariVC.delegate = self
                }
            }else if(call.method=="shareTrip"){
                if let link = NSURL(string: (call.arguments as! Array)[1]) {
                    let objectsToShare = [(call.arguments as! Array)[0],link] as [Any]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    controller.present(activityVC, animated: true, completion: nil)
                }
            }
        });


        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
