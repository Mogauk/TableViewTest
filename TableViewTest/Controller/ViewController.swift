//
//  ViewController.swift
//  TableViewTest
//
//  Created by Alexey on 6/8/22.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var personalDataLabel: UILabel!
    
    @IBOutlet weak var addChildButton: UIButton!
    
    @IBOutlet weak var childCountLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var nameField: RoundedTextField! {
        didSet {
            nameField.tag = 0
            nameField.becomeFirstResponder()
            nameField.delegate = self
        }
    }
    
    @IBOutlet weak var ageField: RoundedTextField!{
        didSet {
            ageField.tag = 1
            ageField.delegate = self
        }
    }
    
    var userData: UserData = UserData(name: "", age: "", child: []) {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        clearButton.isHidden = true
        
        // dismiss keyboard
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func removeChild(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point)
        else {return}
        
        userData.child.remove(at: indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .right)
        tableView.endUpdates()
        print(userData.child.count)
        
        if userData.child.count < 5 {
            addChildButton.isHidden = false
        }
        
        if userData.child.count < 1 {
            clearButton.isHidden = true
        }
        
    }
    
    @IBAction func addChildAction(_ sender: UIButton) {
        
        let child: Child = Child(nameChild: "", ageChild: "")
        self.userData.child.insert(child, at: 0)
        
        print(userData.child.count)
        
        if userData.child.count >= 5 {
            addChildButton.isHidden = true
        

        }
        
    }
    
    
    @IBAction func eraseAll(_ sender: UIButton) {
        print("erase")
        showActionSheet()
        
    }
    
    func showActionSheet() {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "Стереть все данные?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        let eraseAction = UIAlertAction(title: "Сбросить данные", style: .destructive, handler: {(optionMenu) in
            
            self.nameField.text = ""
            self.ageField.text = ""
            self.nameField.becomeFirstResponder()
            
            
            self.userData.child.removeAll()
            
            
            self.clearButton.isHidden = true
            self.addChildButton.isHidden = false
            
            print(self.userData.child.count)
            
        })
        optionMenu.addAction(eraseAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.child.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChildrenTableViewCell.self), for: indexPath) as! ChildrenTableViewCell
        
        cell.childNameField.text = ""
        cell.childAgeField.text = ""
        
        if userData.child.count >= 1 {
            clearButton.isHidden = false
        }
        
        return cell
        
    }
}
