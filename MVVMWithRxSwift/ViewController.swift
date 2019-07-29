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

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { me, color in
            me.messageLabel.textColor = color
        }
    }
    
    private lazy var viewModel = ViewModel(idTextObservable: idTextField.rx.text.asObservable(), passwordTextObservable: passwordTextField.rx.text.asObservable(), model: Model())
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.validationText.bind(to: messageLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.loadLabelColor.bind(to: loadLabelColor).disposed(by: disposeBag)
    }
}

