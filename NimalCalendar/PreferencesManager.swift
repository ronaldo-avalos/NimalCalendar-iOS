//
//  PreferencesManager.swift
//  NimalCalendar
//
//  Created by Ronaldo Avalos on 17/04/24.
//

import Foundation

class PreferencesManager {
    
    let vibrationEnabledKey = "VibrationEnabled"
    let animationSelectDay = "animationSelectDay"
    

    public  func saveVibrationEnabled(_ enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: vibrationEnabledKey)
    }
    public func isVibrationEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: vibrationEnabledKey)
    } 
    
    //Animations
    public  func saveAnimationSelectDayEnabled(_ enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: animationSelectDay)
    }
    public func isAnimationSelectDayEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: animationSelectDay)
    }
    
    
    
    
    
}
