//
//  Utility.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 5/14/20.
//  Copyright © 2020 Ravindra Arya. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    static func cropImage(image: UIImage, toRect: CGRect) -> UIImage? {
        // Cropping is available trhough CGGraphics
        let cgImage :CGImage! = image.cgImage
        let croppedCGImage: CGImage! = cgImage.cropping(to: toRect)

        return UIImage(cgImage: croppedCGImage)
    }
    
    
    static func convertDateTimeStringToDate(string : String, DateFormat : String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat
        return dateFormatter.date(from: string)!
    }
    
    static func getDateFromTimeStampByFormat(from : Date, _ format:String = "hh:mm a") -> String?
    {
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = format
        dayTimePeriodFormatter.locale = Locale(identifier: "en_US_POSIX")
        dayTimePeriodFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dayTimePeriodFormatter.string(from: from as Date)
    }

    static func getProgrammWidth(start: Date, end: Date) -> CGFloat {
        let intervals = start.timeIntervalSince(end)
        let numberOfHours = CGFloat(intervals / 3600)
        return CGFloat(numberOfHours) * (408 * 2)
    }
}
