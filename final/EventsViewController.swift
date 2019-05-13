//
//  EventsViewController.swift
//  final
//
//  Created by taylor parks on 5/6/19.
//  Copyright © 2019 taylor parks. All rights reserved.
//

import UIKit
import FirebaseDatabase
var newPostData = [[String: String]]()
//var selection:Int = 0
//var newPostData = [[String: String]]()

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var newPostData = [String]()
    var postKey = [String]()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell")
        cell?.textLabel?.text = newPostData[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPostData.count
    }
    
//swipe delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let theKey = postKey[indexPath.row]
            newPostData.remove(at: indexPath.row)
            postKey.remove(at: indexPath.row)
            
            ref?.child("EventPosts").child("\(theKey)").removeValue()
            tableView.endUpdates()
        }
    }
//end swipe delete
    
    @IBOutlet weak var eventsHead: UILabel!
    
    @IBOutlet weak var descripLabel: UILabel!
    
    @IBOutlet weak var eventView: UITextView!
    
    @IBAction func addPost(_ sender: Any) {
        ref?.child("EventPosts").childByAutoId().setValue(eventView.text)
        eventView.resignFirstResponder()
        eventView.text = ""    }
    
    @IBOutlet weak var eventTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.delegate = self
        eventTable.dataSource = self
 
        eventView.becomeFirstResponder()
        
        eventTable.allowsMultipleSelectionDuringEditing = true
        
        ref=Database.database().reference()
        
        ref?.child("EventPosts").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            self.newPostData.append(post!)
            let key = snapshot.key
            self.postKey.append(key)
            self.eventTable.reloadData()
            
        })
        
        // Do any additional setup after loading the view.

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



}
}
