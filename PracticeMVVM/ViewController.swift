//
//  ViewController.swift
//  PracticeMVVM
//
//  Created by Apple on 6/18/20.
//  Copyright © 2020 NguyenDucLuu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var txtNameSearch: UITextField!
    @IBOutlet weak var myTBL: UITableView!
    
    var userViewModel = UserViewModel()
    let disposerBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindUI()
    }
    
    func bindUI() {
        self.txtNameSearch.rx.text.throttle(.seconds(1), scheduler: MainScheduler.instance).asObservable().bind(to: self.userViewModel.searchText).disposed(by: disposerBag)
        
        self.userViewModel.searchResult.asObservable().bind(to: self.myTBL.rx.items(cellIdentifier: "CELL", cellType: ItemTableViewCell.self)){
            (index,user,cell) in
            cell.lblName.text = user.userName
            cell.lblId.text = String(user.id)
        }.disposed(by: disposerBag)
    }


}

