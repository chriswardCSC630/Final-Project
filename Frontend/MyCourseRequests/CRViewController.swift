//
//  CRViewController.swift
//  MyCourseRequests
//
//  Created by Eric on 5/23/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import CoreData
/*
class CRViewController: UIViewController, UITableViewDataSource {

    // Labels
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var term: UILabel!
    
    // TableViews
    @IBOutlet weak var courseTableView: UITableView!
    
    // Buttons
    @IBOutlet weak var addNewCourseButton: UIButton!
    @IBOutlet weak var plusNewCourseButton: UIButton!
    
    // Segmented Control
    @IBOutlet weak var saveSubmitControl: UISegmentedControl!
    
//    var allCourses:[Course] = []
    var allSports:[Sport] = []
    
//    var courseGroups:[[Course]] = []
    var hasLoaded = false
    
    var hash_id = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        hash_id = UserDefaults.standard.string(forKey: "hash_id") ?? ""
        name.text = UserDefaults.standard.string(forKey: "name") ?? "Unknown name"
        term.text = UserDefaults.standard.string(forKey: "term") ?? "Unknown"
        
        courseTableView.dataSource = self
        // Do any additional setup after loading the view.
        
//        if courseGroups.count >= 5 {
//            addNewCourseButton.isEnabled = false
//            plusNewCourseButton.isEnabled = false
//        }
//        else {
//            addNewCourseButton.isEnabled = true
//            plusNewCourseButton.isEnabled = true
//        }
    }
  
    
    func makeURLRequest(urlString: String, method: String, paramToSend: String? = "") {
        
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        
        let request = NSMutableURLRequest(url: url!)
        request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: HTTPCookieStorage.shared.cookies!) // for cookies, from http://lucasjackson.io/realtime-ios-chat-with-django/
        
        request.httpMethod = method
        
        if (method == "POST" || method == "PATCH" || method == "DELETE") {
            let params: String = paramToSend ?? ""
            request.httpBody = params.data(using: String.Encoding.utf8)
        }
        
        
        let task = session.dataTask(with: request as URLRequest) { // completionHandler code is implied
            (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                print("error retrieving data from server, error:")
                print(error as Any)
                DispatchQueue.main.async {
                    MyActivityIndicator.removeAll()
                }
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                DispatchQueue.main.async {
                    MyActivityIndicator.removeAll()
                }
                return
            }
            
            let json: Any?
            do {
                json = try JSONSerialization.jsonObject(with: responseData, options: [])
            }
            catch {
                print("error trying to convert data to JSON")
                print(String(data: responseData, encoding: String.Encoding.utf8) ?? "[data not convertible to string]")
                DispatchQueue.main.async {
                    MyActivityIndicator.removeAll()
                }
                return
            }
            
            guard let serverResponse = json as? NSDictionary else {
                print("error trying to convert data to NSDictionary")
                DispatchQueue.main.async {
                    MyActivityIndicator.removeAll()
                }
                return
            }
            
//            else if (method == "POST") {
//                if memory == nil {
//                    print("Memory passed in incompatible format -- POST")
//                    DispatchQueue.main.async {
//                        MyActivityIndicator.removeAll()
//                    }
//                    return
//                }
//                self.updateMemoryID(serverResponse: serverResponse, memory: memory!)
//            }
//            else if (method == "PATCH") {
//                MyActivityIndicator.removeAll()
//                return
//            }
//            else if (method == "DELETE") {
//                MyActivityIndicator.removeAll()
//                return
//            }
            
            
        }
        task.resume()
    }
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCourses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell indentifier
        let cellIdentifier = "CourseTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CourseTableViewCell else {
            fatalError("The dequeued cell is not an instance of CourseTableViewCell.")
        }
        
        // Fetches the appropriate course for the data source layout
        let courseGroup = courseGroups[indexPath.row]
        cell.mainCourse.text = courseGroup[0].title
        cell.period.text = String(courseGroup[0].period)
        cell.alt1.text = courseGroup[1].title
        cell.alt1Period.text = String(courseGroup[1].period)
        cell.alt2.text = courseGroup[2].title
        cell.alt2Period.text = String(courseGroup[2].period)
        cell.alt3.text = courseGroup[3].title
        cell.alt3Period.text = String(courseGroup[3].period)

        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
*/
