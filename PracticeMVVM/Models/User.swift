//
//  User.swift
//  PracticeMVVM
//
//  Created by Apple on 6/18/20.
//  Copyright © 2020 NguyenDucLuu. All rights reserved.
//

import Foundation

struct User {
    var userName:String!
    var id:Int!
    
    init() {
        self.userName = ""
        self.id = 0
    }
    
    init(object:Any) {
        if let dic:Dictionary<String,Any> = object as? Dictionary<String,Any> {
            if let userName = dic["login"] as? String{
                self.userName = userName
            } else {
                self.userName = ""
            }
            if let id = dic["id"] as? Int{
                self.id = id
            } else {
                self.id = 0
            }
        } else {
            self.userName = ""
            self.id = 0
        }
    }
}
