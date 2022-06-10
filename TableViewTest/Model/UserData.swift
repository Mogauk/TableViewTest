//
//  UserData.swift
//  TableViewTest
//
//  Created by Alexey on 6/8/22.
//

import Foundation

struct UserData {
    
    var name: String = ""
    var age: String = ""
    var child: [Child] = []
    
}

struct Child: Hashable {
    
    var nameChild: String = ""
    var ageChild: String = ""
}
