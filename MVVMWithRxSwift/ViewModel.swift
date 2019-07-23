
//
//  ViewModel.swift
//  MVVMWithRxSwift
//
//  Created by Atsushi KONISHI on 2019/07/24.
//  Copyright © 2019 小西篤志. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ViewModel {
    let validationText: Observable<String>
    let loadLabelColor: Observable<UIColor>
    
    init(idTextObservable: Observable<Optional<String>>, passwordTextObservable: Observable<Optional<String>>, model: ModelProtocol) {
        let event = Observable.combineLatest(idTextObservable, passwordTextObservable)
        .skip(1)
        .flatMap { idText, passwordText -> Observable<Event<Void>> in
            return model.validate(idText: idText, passwordText: passwordText).materialize()
        }.share()
        
        self.validationText = event.flatMap { event -> Observable<String> in
            switch event {
            case .next:
                return .jsut("OK!")
            case let .error(error as ModelError):
                return .just(error.errorText)
            case .error, .completed:
                return .empty()
            }
        }.startWith("input ID and Password.")
        
        self.loadLabelColor = event.flatMap { event -> Observable<UIColor> in
            switch event {
            case .next:
                return .just(.green)
            case .error:
                return .just(.red)
            case .completed:
                return .empty()
            }
        }
    }
}
