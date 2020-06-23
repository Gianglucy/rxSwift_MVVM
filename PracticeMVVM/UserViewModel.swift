//
//  UserViewModel.swift
//  PracticeMVVM
//
//  Created by Apple on 6/18/20.
//  Copyright © 2020 NguyenDucLuu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel:NSObject{
//    Observable
    var searchText = BehaviorRelay<String?>(value: "")
    var searchResult = BehaviorRelay<[User]>(value: [])
    var disposerBag = DisposeBag()
    override init() {
        super.init()
        bindingData()
    }
    
    func bindingData(){
        self.searchText.asObservable().subscribe(onNext: {(text) in
            if text!.isEmpty {
                self.searchResult.accept([])
            } else {
                self.requestResult(url: "https://api.github.com/search/users?q=\(text!)")
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposerBag)
    }
    
    func requestResult(url:String) {
        let url = URL(string: url)
        let session = URLSession.shared
        session.dataTask(with: url!){(data,response,error)in
            if error == nil {
                do{
                    if let result:Dictionary<String,Any> = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String,Any> {
                        var userArray:Array<User> = []
                        if let items:Array<Any> = result["items"] as? Array<Any>{
                            for i in items {
                                let user = User(object: i)
                                userArray.append(user)
                            }
                            self.searchResult.accept(userArray)
                        }
                    }
                } catch{}
            }
        }.resume()
    }
}
