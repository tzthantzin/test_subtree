import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let deviceInfoChannel = FlutterMethodChannel(name: "com.example.flutter.dev/device_info",
                                                     binaryMessenger: controller.binaryMessenger)

        deviceInfoChannel.setMethodCallHandler({ [self]
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "getDeviceInfo" else {
                result(FlutterMethodNotImplemented)
                return
            }
            let deviceInfo = getDeviceInfo()
            if UIDevice.current.model == nil {
                result(FlutterError(code: "UNAVAILABLE",
                                    message: "Device information cannot available for this device",
                                    details: nil))
            } else {
                result(deviceInfo)
            }
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getDeviceInfo () -> [String: Any]{
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model

        var resultMapping: [String: Any] = [String:Any]()
        resultMapping ["model"] = model
        resultMapping ["systemVersion"] = systemVersion
        return resultMapping
    }
}
