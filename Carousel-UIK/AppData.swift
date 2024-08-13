//
//  ApplicationController.swift
//  Carousel-UIK
//
//  Created by Herlandro Hermogenes on 13/08/2024.
//

import Foundation

struct ApplicationController {
    static var shared: ApplicationController = {
        return ApplicationController()
    }()

    func isAppUpdated() -> Bool {
        guard let currentVersion = getCurrentAppVersion() else { return false }
        let lastVersion = UserDefaults.standard.string(forKey: "LastAppVersion")
        return lastVersion == nil || lastVersion != currentVersion
    }

    private func getCurrentAppVersion() -> String? {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"]
        let build = dictionary["CFBundleVersion"]
        return "\(version ?? "") (\(build ?? "")"
    }
}
