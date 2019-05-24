//
//  NewCourseViewController.swift
//  MyCourseRequests
//
//  Created by Eric on 5/24/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class NewCourseViewController: UIViewController {
    @IBOutlet weak var mainCourse: NewCourseView!
    @IBOutlet weak var alt1: NewCourseView!
    @IBOutlet weak var alt2: NewCourseView!
    @IBOutlet weak var alt3: NewCourseView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    
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
        checkStatus()
        
        // Do any additional setup after loading the view.
    }
    
    func checkStatus() {
//        if NewCourseViewController.main_course.id == -1 {
//            alt1.isHidden = true
//            alt2.isHidden = true
//            alt3.isHidden = true
//        }
//        else {
//            alt1.isHidden = false
//            alt2.isHidden = false
//            alt3.isHidden = false
//        }
        
        updateSaveButtonState()
//        if NewCourseViewController.alt1_course.id == -1 {
//            alt2.isHidden = true
//            alt3.isHidden = true
//        } else if NewCourseViewController.alt2_course.id == -1 {
//            alt3.isHidden = true
//        }
    }
    
    func updateSaveButtonState() {
        saveButton.isEnabled = (NewCourseViewController.main_course.id != -1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
