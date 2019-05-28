//
//  NewCourseViewController.swift
//  MyCourseRequests
//
//  Created by Eric on 5/24/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import os.log

class NewCourseViewController: UIViewController {
    @IBOutlet weak var mainCourse: NewCourseView!
    @IBOutlet weak var alt1: NewCourseView!
    @IBOutlet weak var alt2: NewCourseView!
    @IBOutlet weak var alt3: NewCourseView!
    
    var courseGroup: CourseGroup?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    static var main_course: CourseSearchItem = GLOBAL.DEFAULT_COURSE
    static var alt1_course: CourseSearchItem = GLOBAL.DEFAULT_COURSE
    static var alt2_course: CourseSearchItem = GLOBAL.DEFAULT_COURSE
    static var alt3_course: CourseSearchItem = GLOBAL.DEFAULT_COURSE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // So that each time this loads, the courses are reset
        NewCourseViewController.main_course = GLOBAL.DEFAULT_COURSE
        NewCourseViewController.alt1_course = GLOBAL.DEFAULT_COURSE
        NewCourseViewController.alt2_course = GLOBAL.DEFAULT_COURSE
        NewCourseViewController.alt3_course = GLOBAL.DEFAULT_COURSE
        
        // Do any additional setup after loading the view.
    }
    
    func updateSaveButtonState() {
        saveButton.isEnabled = (NewCourseViewController.main_course.id != -1)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Configure the destination view controller only when the save button is presed
        guard let button = sender as? UIButton, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let mc = mainCourse!
        let a1 = alt1 ?? nil
        let a2 = alt2 ?? nil
        let a3 = alt3 ?? nil
        
        // Set the memory to be passed to MemoryTableViewController after the unwind segue.
        courseGroup = CourseGroup(mainCourse: mc, alt1: a1, alt2: a2, alt3: a3)
    }

}
