//
//  SecondViewController.swift
//  To Do List
//
//  Created by Scott Minter on 1/4/17.
//  Copyright © 2017 Scott Minter. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemInput: UITextField!
    let ListKey: String = "todoList"
    var List = [String]()
    
    @IBAction func addItem(_ sender: Any) {
        saveNewItem()
    }
    
    private func saveNewItem() {
        let todoItemOpt: String? = itemInput.text
        
        if todoItemOpt != nil && todoItemOpt! != "" {
            let todoItem: String = todoItemOpt!
            print("item: \(todoItem)")
            
            // add item to List
            List.append(todoItem)
            
            // save new List over old key
            UserDefaults.standard.set(List, forKey: ListKey)
            
            // clear text box
            itemInput.text = ""
            
            // hide keyboard
            self.view.endEditing(true)
        } else {
            print("No Input")
        }
    }
    
    private func updateList() {
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
        
        updateList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        print("view appeared...")
        updateList()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveNewItem()
        textField.resignFirstResponder()
        
        return true
    }
}

