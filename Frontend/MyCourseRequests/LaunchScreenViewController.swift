//
//  LaunchScreenViewController.swift
//  MyCourseRequests
//
//  Created by Chris Ward on 5/23/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController, UITextFieldDelegate {
    // Modified progress bar code (from circlular example to a line) from https://medium.com/@ashikabala01/creating-custom-progress-bar-in-ios-using-swift-c662525b6ed
    
    @IBOutlet weak var progressBar: ProgressBarView!
    var timer: Timer!
    var progressCounter:Float = 0
    let duration:Float = 5
    var progressIncrement:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.layerSetup()
        progressIncrement = 1.0/duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showProgress), userInfo: nil, repeats: true)
    }
    
    @objc func showProgress() {
        if(progressCounter > 1.0){timer.invalidate()}
        progressBar.progress = progressCounter
        progressCounter = progressCounter + progressIncrement
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

// Easy UIColor extension https://stackoverflow.com/questions/8023916/how-to-initialize-uicolor-from-rgb-values-properly
extension UIColor {
    
    convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {
        
        let redPart: CGFloat = CGFloat(red) / 255
        let greenPart: CGFloat = CGFloat(green) / 255
        let bluePart: CGFloat = CGFloat(blue) / 255
        
        self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
        
    }
}
