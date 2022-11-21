//
//  UIDevice+Extensions.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
import UIKit

extension UIDevice {
    // get device type
    var deviceType: String {
        var utsnameInstance = utsname()
        uname(&utsnameInstance)
        let optionalString: String? = withUnsafePointer(to: &utsnameInstance.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String(validatingUTF8: ptr)
            }
        }
        return optionalString ?? "N/A"
        /*
         if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
         var sysinfo = utsname()
         uname(&sysinfo) // ignore return value
         return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)*/
    }

    // get device id
    var deviceId: String {
        if let id = UserDefaults.standard.string(forKey: "deviceId") {
            return id
        }

        let uuid = identifierForVendor?.uuidString ?? "N/A"
        UserDefaults.standard.setValue(uuid, forKey: "deviceId")

        return uuid
    }
    
    var hasNotch: Bool {
        var bottom = 0
        if #available(iOS 13, *) {
            let window = UIApplication.shared.windows.first
            bottom = Int(window?.safeAreaInsets.bottom ?? 0)
        }else{
            bottom = Int(UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        }
        return bottom > 0
    }
}

