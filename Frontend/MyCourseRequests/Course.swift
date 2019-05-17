//
//  Course.swift
//  MyCourseRequests
//
//  Created by Eric on 5/14/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import os.log


class Course: NSObject, NSCoding {
    
    //MARK: Properties
    
    var title: String
    var number: String // the 6-8 character key, i.e. INT540CN
    var desc: String // short for description, everything other than the number above
    var period: Int
    var teacher: String
    var section: Int
    var room: String
    var days: String
    
    //MARK: Archiving Points
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("courses")
    
    
    //MARK: Types
    
    struct PropertyKey{
        static let title = "title"
        static let period = "period"
        static let teacher = "teacher"
        static let section = "section"
        static let room = "room"
        static let days = "days"
    }
    
    //MARK: Initializers
    init?(title: String, period: Int, teacher: String, section: Int, room: String, days: String){
        // Will expect to be initialized with all of the above in the proper formats, as read from the excel spreadsheet
        
        // None of the above must not be empty or negative
        guard !(title.isEmpty || period > 0 || teacher.isEmpty || section > 0 || room.isEmpty || days.isEmpty) else {
            return nil
        }
        
        // Initialize Stored Properties
        self.title = title
        if let i = title.firstIndex(of: ":") {
            // substring from https://useyourloaf.com/blog/swift-string-cheat-sheet/
            self.number = String(title[Range(uncheckedBounds: (lower: title.startIndex, upper: i))])
            self.desc = String(title[Range(uncheckedBounds: (lower: i, upper: title.endIndex))])
        }
        else {
            self.number = "unknown"
            self.desc = title
        }
        self.period = period
        self.teacher = teacher
        self.section = section
        self.room = room
        self.days = days
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(period, forKey: PropertyKey.period)
        aCoder.encode(teacher, forKey: PropertyKey.teacher)
        aCoder.encode(section, forKey: PropertyKey.section)
        aCoder.encode(room, forKey: PropertyKey.room)
        aCoder.encode(days, forKey: PropertyKey.days)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The title is required. If we cannot decode a title string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String
            else {
                os_log("Unable to decode the title for a Course object.", log: OSLog.default,
                       type: .debug)
                return nil
        }
        guard let period = aDecoder.decodeObject(forKey: PropertyKey.period) as? Int
            else {
                os_log("Unable to decode the period for a Course object.", log: OSLog.default,
                       type: .debug)
                return nil
        }
        guard let teacher = aDecoder.decodeObject(forKey: PropertyKey.teacher) as? String
            else {
                os_log("Unable to decode the teacher for a Course object.", log: OSLog.default,
                       type: .debug)
                return nil
        }
        guard let section = aDecoder.decodeObject(forKey: PropertyKey.section) as? Int
            else {
                os_log("Unable to decode the section for a Course object.", log: OSLog.default,
                       type: .debug)
                return nil
        }
        guard let room = aDecoder.decodeObject(forKey: PropertyKey.room) as? String
            else {
                os_log("Unable to decode the room for a Course object.", log: OSLog.default,
                       type: .debug)
                return nil
        }
        guard let days = aDecoder.decodeObject(forKey: PropertyKey.days) as? String
            else {
                os_log("Unable to decode the days for a Course object.", log: OSLog.default,
                       type: .debug)
                return nil
        }
        
        

        
        // Must call designated initializer.
        self.init(title: title, period: period, teacher: teacher, section: section, room: room, days: days)
    }
}

