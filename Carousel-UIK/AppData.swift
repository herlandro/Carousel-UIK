//
//  AppData.swift
//  Carousel-UIK
//
//  Created by Herlandro Hermogenes on 13/08/2024.
//

import Foundation

struct AppData {
    static var shared: AppData = {
        return AppData()
    }()

    var isAppUpdated: Bool {
        guard let currentVersion = currentVersion else { return false }
        let lastVersion = UserDefaults.standard.string(forKey: "LastAppVersion")
        return lastVersion == nil || lastVersion != currentVersion
    }

    var currentVersion: String? {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"]
        let build = dictionary["CFBundleVersion"]
        return "\(version ?? "") (\(build ?? "")"
    }
}
