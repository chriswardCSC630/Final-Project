//
//  Course.swift
//  MyCourseRequests
//
//  Created by Chris Ward on 5/27/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import os.log

class CourseGroup: NSObject, NSCoding {
    
    //MARK: Properties
    
    var mainCourse: NewCourseView!
    var alt1: NewCourseView!
    var alt2: NewCourseView!
    var alt3: NewCourseView!
    var id: String?
    
    //MARK: Archiving Points
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("memories")
    
    
    //MARK: Types
    
    struct PropertyKey{
        static let mainCourse = "mainCourse"
        static let alt1 = "alt1"
        static let alt2 = "alt2"
        static let alt3 = "alt3"
        static let id = "id"
    }
    
    //MARK: Initializers
    init?(mainCourse: NewCourseView, alt1: NewCourseView?, alt2: NewCourseView?, alt3: NewCourseView?){
        
        // Initialize Stored Properties
        self.mainCourse = mainCourse
        self.alt1 = alt1
        self.alt2 = alt2
        self.alt3 = alt3
        
        // id will start as an empty string and will be set when memory is POSTed or from GET of all memories
        self.id = ""
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(mainCourse, forKey: PropertyKey.mainCourse)
        aCoder.encode(alt1, forKey: PropertyKey.alt1)
        aCoder.encode(alt2, forKey: PropertyKey.alt2)
        aCoder.encode(alt3, forKey: PropertyKey.alt3)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The title is required. If we cannot decode a title string, the initializer should fail.
        guard let mainCourse = aDecoder.decodeObject(forKey: PropertyKey.mainCourse) as? NewCourseView
            else {
                os_log("Unable to decode the mainCourse for a Course object.", log: OSLog.default,
                       type: .debug)
                return nil
        }
        
        // Because alternates are optional properties of Course, just use conditional cast.
        let alt1 = aDecoder.decodeObject(forKey: PropertyKey.alt1) as? NewCourseView
        let alt2 = aDecoder.decodeObject(forKey: PropertyKey.alt2) as? NewCourseView
        let alt3 = aDecoder.decodeObject(forKey: PropertyKey.alt3) as? NewCourseView
        
        // Must call designated initializer.
    self.init(mainCourse: mainCourse, alt1: alt1, alt2: alt2, alt3: alt3)
    }
}
