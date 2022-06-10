//
//  ChildrenTableViewCell.swift
//  TableViewTest
//
//  Created by Alexey on 6/8/22.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var childNameField: RoundedTextField!{
        didSet {
            childNameField.tag = 0
            childNameField.delegate = self
        }
    }
    
    @IBOutlet weak var childAgeField: RoundedTextField!{
        didSet {
            childAgeField.tag = 1
            childAgeField.delegate = self
        }
    }
    
    @IBOutlet weak var deleteChildButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ChildrenTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
        
    }
}
