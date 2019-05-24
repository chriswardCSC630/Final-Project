//
//  NewCourseViewController.swift
//  MyCourseRequests
//
//  Created by Eric on 5/23/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class NewCourseViewController: UIViewController {

    @IBOutlet weak var mainSearchField: CustomSearchTextField!
    @IBOutlet weak var hideMainLabels: UIView!
    @IBOutlet weak var mainTeacher: UILabel!
    @IBOutlet weak var mainPeriod: UILabel!
    @IBOutlet weak var mainRoom: UILabel!
    @IBOutlet weak var mainDays: UILabel!
    
    @IBOutlet weak var resetMainButton: UIButton!
    
    
    static var mainCourse: CourseSearchItem = CourseSearchItem(id: -1, title: " ", period: " ", teacher: " ", section: " ", room: " ", days: " ")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // technically both of these statements together are redundant, but just to be consistent we're using them both
        if NewCourseViewController.mainCourse.id == -1 {
            hideMainLabels.isHidden = false
            updateMainLabels("")
            resetMainButton.isHidden = true
        }
        else {
            hideMainLabels.isHidden = true
            resetMainButton.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetMainCourse(_ sender: Any) {
        NewCourseViewController.mainCourse = CourseSearchItem(id: -1, title: " ", period: " ", teacher: " ", section: " ", room: " ", days: " ")!
        mainSearchField.isEnabled = true
        mainSearchField.text = ""
        resetMainButton.isEnabled = false
        
    }
    
    @IBAction func updateMainLabels(_ sender: Any) {
        self.mainTeacher.text = NewCourseViewController.mainCourse.teacher
        self.mainPeriod.text = NewCourseViewController.mainCourse.period
        self.mainRoom.text = NewCourseViewController.mainCourse.room
        self.mainDays.text = NewCourseViewController.mainCourse.days
    }
    

    static func setMainCourse(course: CourseSearchItem) {
        mainCourse = course
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
