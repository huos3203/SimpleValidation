//
//  SimpleValidationViewController.swift
//  SimpleValidation
//
//  Created by admin on 2018/10/5.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class SimpleValidationViewController : ViewController {
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default
        
        /// 密码验证可被监听的序列
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        /// 合并可被监听的序列
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        /// 订阅生命周期
        let disposeBag = DisposeBag()
        
        /// 用户名无效时，密码框不可用
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        /// 用户名无效时，显示无效提示语
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        /// 密码无效时，显示无效提示语
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        /// 两个序列无效时，登陆按钮不可用
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        /// 登陆按钮响应事件
        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
    
}
