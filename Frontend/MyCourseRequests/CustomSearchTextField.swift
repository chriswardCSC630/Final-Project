//
//  CustomSearchTextField.swift
//  MyCourseRequests
//
//  Created by Eric on 5/23/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import CoreData

// INSTRUCTIONS FROM: https://medium.freecodecamp.org/how-to-create-an-autocompletion-uitextfield-using-coredata-in-swift-dbedad03ea3d

class CustomSearchTextField: UITextField, UITableViewDelegate, UITableViewDataSource {
    
    var dataList: [Courses] = [Courses]()
    var resultsList: [CourseSearchItem] = [CourseSearchItem]()
    var tableView: UITableView?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    // Connecting the new element to the parent view
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
    }
    
    // Create SearchTableview
    func buildSearchTableView() {
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomSearchTextFieldCell")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)
            
        } else {
            print("tableView created")
            tableView = UITableView(frame: CGRect.zero)
        }
        
        updateSearchTableView()
    }
    
    
    
    // MARK: TableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataList.count)
        return dataList.count
    }
    
    //Adding rows in the tableview with the data from dataList
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSearchTextFieldCell", for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = dataList[indexPath.row].title
        return cell
    }
    
    // MARK: TableViewDelegate methods
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row")
        self.text = dataList[indexPath.row].title
        tableView.isHidden = true
        self.endEditing(true)
    }
    
    // Updating SearchtableView
    func updateSearchTableView() {
        
        if let tableView = tableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height
            
            // Set a bottom margin of 10p
            if tableHeight < tableView.contentSize.height {
                tableHeight -= 10
            }
            
            // Set tableView frame
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = tableViewFrame
            })
            
            //Setting tableView style
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 5.0
            tableView.separatorColor = UIColor.lightGray
            tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.reloadData()
        }
    }
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
    }
    
    // MARK : Filtering methods
    fileprivate func filter() {
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", self.text!)
        let request : NSFetchRequest<Courses> = Courses.fetchRequest()
        request.predicate = predicate
        
        //Loading the data into the dataList
        loadItems(withRequest : request)
        
        resultsList = []
        
        for i in 0 ..< dataList.count {
            let item = CourseSearchItem(id: Int(dataList[i].id), title: dataList[i].title!, period: dataList[i].period!, teacher: dataList[i].teacher!, section: dataList[i].section!, room: dataList[i].room!, days: dataList[i].days!)!
    
            
            let titleFilterRange = (item.title as NSString).range(of: text!, options: .caseInsensitive)
            
            if titleFilterRange.location != NSNotFound {
                item.attributedTitle! = NSMutableAttributedString(string: item.title)

                
                item.attributedTitle!.setAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], range: titleFilterRange)
                resultsList.append(item)
            }
        }
        tableView?.reloadData()
    }

    
    //////////////////////////////////////////////////////////////////////////////
    // Data Handling methods
    //////////////////////////////////////////////////////////////////////////////
    
    
    // MARK: CoreData manipulation methods
    
    // Don't need this function in this case
    func saveItems() {
        print("Saving items")
        do {
            try context.save()
        } catch {
            print("Error while saving items: \(error)")
        }
    }
    
    func loadItems(withRequest request : NSFetchRequest<Courses>) {
        print("loading items")
        do {
            dataList = try context.fetch(request)
        } catch {
            print("Error while fetching data: \(error)")
        }
    }
    
    
    //////////////////////////////////////////////////////////////////////////////
    // Text Field related methods
    //////////////////////////////////////////////////////////////////////////////
    
    @objc func textFieldDidChange(){
        print("Text changed ...")
        updateSearchTableView()
        
    }
    
    @objc public func textFieldDidBeginEditing() {
        print("Begin Editing")
    }
    
    @objc func textFieldDidEndEditing() {
        print("End editing")
    }
    
    @objc func textFieldDidEndEditingOnExit() {
        print("End on Exit")
    }

}
