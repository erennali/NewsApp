//
//  NotificationManager.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 15.05.2025.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    public static let shared : NotificationManager = NotificationManager()
    private var center = UNUserNotificationCenter.current()
    public var isRequested: Bool = false
    
    private var notificationSettings: UNAuthorizationStatus = .notDetermined
    public var isAuthorized: Bool {
        notificationSettings == .authorized
    }
    private init() {}
    
    func requestNotificationPermissionWithAsync() async throws {
        let result = try await center.requestAuthorization(options: [.alert, .badge, .sound])
        isRequested = true
        print("AUTHORIATION STATUS: \(result)")
    }
    @discardableResult
    func updateNotificationStatus() async -> UNAuthorizationStatus {
        let status = await center.notificationSettings().authorizationStatus
        notificationSettings = status
        return status
    }
}
