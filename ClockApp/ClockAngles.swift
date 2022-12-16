//
//  ClockAngles.swift
//  ClockApp
//
//  Created by Mike Quinn on 12/14/22.
//

import SwiftUI

struct ClockAngles {
    var hour: Angle
    var minute: Angle
    var second: Angle
    
    init(for date: Date) {
        let components = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: date)
        
        let hourComponent = components.hour ?? 0
        let minuteComponent = Double(components.minute ?? 0)
        let secondComponent = Double(components.second ?? 0)
        let nanosecondComponent = Double(components.nanosecond ?? 0)
        
        hour = .degrees(30 * (Double(hourComponent % 12) + minuteComponent / 60) + 180)
        minute = .degrees(6 * (minuteComponent + secondComponent / 60) + 180)
        second = .degrees(6 * (secondComponent + nanosecondComponent / 1_000_000_000) + 180)
        
        if (hour.radians == .pi) { hour = .radians(3.141) }
        if (minute.radians == .pi) { minute = .radians(3.141) }
        if (second.radians == .pi) { second = .radians(3.141) }
    }
}
