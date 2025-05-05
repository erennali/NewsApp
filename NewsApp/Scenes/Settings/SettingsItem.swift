//
//  SettingsItem.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 5.05.2025.
//

import Foundation

enum SettimgsItemType {
    case theme
    case notification
    case rateApp
    case privacyPolicy
    case termsOfUse
}

struct SettingsItem {
    let title: String
    let iconName: String
    let type: SettimgsItemType
}

struct SettingsSection {
    let title: String
    let items: [SettingsItem]
    
    static let sections: [SettingsSection] = [
        SettingsSection(title: "Appearance", items: [
            SettingsItem(title: "App Theme", iconName: "circle.righthalf.filled", type: .theme),
        ]),
        SettingsSection(title: "Notifications", items: [
            SettingsItem(title: "Notification", iconName: "bell.fill", type: .notification),
        ]),
        SettingsSection(title: "Rate Us", items: [
            SettingsItem(title: "Rate Us", iconName: "star.fill", type: .rateApp),
        ]),
        SettingsSection(title: "Legal", items: [
            SettingsItem(title: "Privacy Policy", iconName: "text.document.fill", type: .privacyPolicy),
            SettingsItem(title: "Terms of Use", iconName: "checkmark.shield.fill", type: .termsOfUse),
        ])
    ]
}

