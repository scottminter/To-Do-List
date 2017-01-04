//
//  FirstViewController.swift
//  To Do List
//
//  Created by Scott Minter on 1/4/17.
//  Copyright © 2017 Scott Minter. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todoTable: UITableView!
    let ListKey: String = "todoList"
    var List: [String] = []
    var deletePlanetIndexPath: NSIndexPath? = nil

    // Number of items in list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.count
    }
    
    // Handles each item in list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "todoListCell")
        let i = indexPath.row
        
        if i < List.count {
            cell.textLabel?.text = List[i]
        }
        
        return cell
    }
    
    // Hanldes deleting item from list
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            List.remove(at: indexPath.row)
            UserDefaults.standard.set(List, forKey: ListKey)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            print("insert item")
        }
    }

    // Updates this view's copy of List
    func updateList() {
        let todoListObj = UserDefaults.standard.object(forKey: ListKey)
        if let list = todoListObj as? Array<String> {
            List = list
            print(List)
        } else {
            print("No todo list found")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let arr1 = [String]()
        //UserDefaults.standard.set(arr1, forKey: "todoList")
        updateList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        updateList()
        todoTable.reloadData()
    }
}

