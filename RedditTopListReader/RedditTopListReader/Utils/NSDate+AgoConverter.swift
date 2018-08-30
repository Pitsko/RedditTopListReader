//
//  NSDate+AgoConverter.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import Foundation

// We should not create formatters each time ans it is expensive operation, also I donwt want to create different formatters for different components
private struct DateFormatters {
    static let timeAgo: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        formatter.collapsesLargestUnit = true
        formatter.includesApproximationPhrase = false
        return formatter
    }()
}


extension Date {
    func timeAgoFormat () -> String {
        let calendar = NSCalendar.current
        let components1: Set<Calendar.Component> = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        let components = calendar.dateComponents(components1, from: self, to: Date())
        
        let formatter = DateFormatters.timeAgo
        
        // TODO: Improve this if/else code
        if components.year ?? 0 > 0 {
            formatter.allowedUnits = .year
        } else if components.month ?? 0 > 0 {
            formatter.allowedUnits = .month
        } else if components.weekOfMonth ?? 0 > 0 {
            formatter.allowedUnits = .weekOfMonth
        } else if components.day ?? 0 > 0 {
            formatter.allowedUnits = .day
        } else if components.hour ?? 0 > 0 {
            formatter.allowedUnits = .hour
        } else if components.minute ?? 0 > 0 {
            formatter.allowedUnits = .minute
        } else {
            formatter.allowedUnits = .second
        }
        
        
        guard let timeString = formatter.string(from: self, to: Date()) else {
            assertionFailure("Not possible to convert to 'ago' format")
            return ""
        }
        
        
        let formatString = NSLocalizedString("%@ ago", comment: "Used to say how much time has passed. e.g. '2 hours ago'")
        return String(format: formatString, timeString)
    }
}
