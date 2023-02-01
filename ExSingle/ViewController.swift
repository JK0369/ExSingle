//
//  ViewController.swift
//  ExSingle
//
//  Created by 김종권 on 2023/02/01.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let observable = Observable<Int>.create { observer in
        observer.onNext(10)
        print("finish")
        return Disposables.create()
    }

    let single = Single<Int>.create { observer in
        observer(.success(1)) // 또는 observer(.error())
        return Disposables.create()
    }

    let completable = Completable.create { observer in
        observer(.completed) // 또는 observer(.error())
        return Disposables.create()
    }

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSomeObservable()
            .debug("debug0>")
            .subscribe()
            .disposed(by: disposeBag)
        // subscribed > next(1)
        
        single
            .debug("debug1>")
            .subscribe()
            .disposed(by: disposeBag)
        // subscribed > next(1) > completed > isDisposed
        
        completable
            .debug("debug2>")
            .subscribe()
            .disposed(by: disposeBag)
        // subscribed > completed > isDisposed
    }
    
    private func getSomeObservable() -> Observable<Int> {
        .create { observer in
            observer.onNext(1)
            return Disposables.create()
        }
    }
}
