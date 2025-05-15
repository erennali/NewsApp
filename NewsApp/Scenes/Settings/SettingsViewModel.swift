//
//  SettingsViewModel.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 5.05.2025.
//

import Foundation
import UserNotifications

class SettingsViewModel {
    
    // MARK: - Properties
    
    var sections = SettingsSection.sections
    
    private let themeKey = "selectedTheme"
    private var notificationManager : NotificationManager = .shared
    
    weak var delegate: SettingsViewControllerProtocol?
    
    init() {
        // Initialization code if needed
    }
    
    
}

// MARK: -  Methods

 extension SettingsViewModel {
    func fetchThemeMode() -> Int {
      UserDefaults.standard.integer(forKey: themeKey)
  }
     
     //kullanıcı ilk kez izin istediğinde ve açmak istediğinde
     func updateNotificationStatus(isOn: Bool) {
         
         Task {
             if !notificationManager.isRequested && isOn {
                 try await notificationManager.requestNotificationPermissionWithAsync()
                 await notificationManager.updateNotificationStatus()
                 delegate?.updateSwitchValue(notificationManager.isAuthorized)
             }else {
                 delegate?.openAppSettings()
             }
            
         }
     }

     func fetchNotificationStatus(completion: @escaping (Bool) -> Void) {
          completion(notificationManager.isAuthorized)
     }
}
