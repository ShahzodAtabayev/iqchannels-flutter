import Flutter
import UIKit
import IQChannelsSwift

public class IqchannelsPlugin: NSObject, FlutterPlugin {
    let configurationManager: IQLibraryConfigurationProtocol = IQLibraryConfiguration()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "iqchannels", binaryMessenger: registrar.messenger())
        let instance = IqchannelsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {

        case "configure":
            if let args = call.arguments as? [String: Any],
               let address = args["address"] as? String,
               let channelName = args["channel"] as? String {
                let style = args["style"] as? String
                let language = args["language"] as? String
                let theme = args["theme"] as? String
                let styleData = style.data(using: .utf8)
                let languageData = language.data(using: .utf8)
                let config = IQChannelsConfig(address: address, channels: [channelName], styleJson: styleData, languageJson: languageData)
                if theme != nil {
                    if theme == "light" {
                        configurationManager.setTheme(.light)
                    } else if theme == "dark" {
                        configurationManager.setTheme(.dark)
                    } else {
                        configurationManager.setTheme(.system)
                    }
                }
                configurationManager.configure(config)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "address and channel required", details: nil))
            }

        case "saveLanguageJson":
            guard
                let args = call.arguments as? [String: Any],
                let fileName = args["fileName"] as? String,
                let jsonContent = args["jsonContent"] as? String
            else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "fileName and jsonContent required", details: nil))
                return
            }

            let fileManager = FileManager.default
            do {
                let appSupportDir = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let destinationURL = appSupportDir.appendingPathComponent(fileName)

                // Delete file if exits
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }

                // Write file
                try jsonContent.write(to: destinationURL, atomically: true, encoding: .utf8)
                result(nil)
            } catch {
                result(FlutterError(code: "WRITE_ERROR", message: "Failed to write file: \(error)", details: nil))
            }

        case "setTheme":
            if let args = call.arguments as? [String: Any],
               let theme = args["theme"] as? String {
                if theme == "light" {
                    configurationManager.setTheme(.light)
                } else if theme == "dark" {
                    configurationManager.setTheme(.dark)
                } else {
                    configurationManager.setTheme(.system)
                }
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "theme required", details: nil))
            }

        case "login":
            if let args = call.arguments as? [String: Any],
               let token = args["token"] as? String {
                configurationManager.login(.credentials(token))
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "token required", details: nil))
            }

        case "logout":
            configurationManager.logout()
            result(nil)

        case "loginAnonymous":
            configurationManager.login(.anonymous)
            result(nil)

        case "logoutAnonymous":
            configurationManager.logout()
            result(nil)

        case "openChat":
            var rootViewController: UIViewController? = UIApplication.shared.connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }?
            .rootViewController

            if rootViewController == nil {
                rootViewController = UIApplication.shared.keyWindow?.rootViewController
            }

            guard let controller = rootViewController else {
                result(FlutterError(code: "NO_CONTROLLER", message: "Cannot get rootViewController", details: nil))
                return
            }

            guard let chatVC = configurationManager.getViewController() else {
                result(FlutterError(code: "NO_CONTROLLER", message: "Cannot get getViewController", details: nil))
                return
            }

            DispatchQueue.main.async {
                controller.present(chatVC, animated: true, completion: nil)
            }

            result(nil)

        case "setPushToken":
            if let args = call.arguments as? [String: Any],
               let token = args["token"] as? String {
                let data = Data(token.utf8)
                configurationManager.pushToken(data)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "token required", details: nil))
            }

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
