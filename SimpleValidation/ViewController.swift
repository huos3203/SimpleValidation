//
//  ViewController.swift
//  SimpleValidation
//
//  Created by admin on 2018/10/4.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var ibUsernameField: UITextField!
    @IBOutlet weak var ibPwdField: UITextField!
    @IBOutlet weak var ibSubmitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    //MARK:输入框相关代理
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textLength:Int! = textField.text?.count
        textField.layer.borderWidth = 1;
        //描边
        if textLength! < 5 {
            textField.layer.borderColor =  #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }else{
            textField.layer.borderColor =  #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textLength:Int! = textField.text?.count
        if textLength! < 5 {
            return false
        }
        return true
    }
    
    
    /// 验证
    /// 提示结果
    /// - Parameter sender: 验证按钮
    @IBAction func ibSubmitAction(_ sender: Any) {
        //开始验证
        ibUsernameField.resignFirstResponder()
        ibPwdField.resignFirstResponder()
        let alterView = UIAlertController.init(title: "验证结果", message: "验证完成", preferredStyle: .alert)
        alterView.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alterView, animated: true, completion: nil)
    }
}

