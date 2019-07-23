//
//  ViewController.swift
//  MVVMWithRxSwift
//
//  Created by Atsushi KONISHI on 2019/07/24.
//  Copyright © 2019 小西篤志. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var idTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

