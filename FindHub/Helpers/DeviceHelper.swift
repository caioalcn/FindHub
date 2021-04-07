//
//  DeviceHelper.swift
//  FindHub
//
//  Created by Caio Alcântara on 07/04/21.
//

import Foundation
import UIKit
import SystemConfiguration

class DeviceHelper {
    
    static let osSystemVersion = ProcessInfo().operatingSystemVersion
    
    class func os() -> String {
        return "iOS \(UIDevice.current.systemVersion)"
    }
    
    class func version() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    class func versionBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
  
    class func bundleID() -> String {
        return Bundle.main.bundleIdentifier!
    }

    class func appName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
}
