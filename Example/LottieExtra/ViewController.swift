//
//  ViewController.swift
//  LottieExtra
//
//  Created by oxape on 05/24/2019.
//  Copyright (c) 2019 oxape. All rights reserved.
//

import UIKit
import LottieExtra

class ViewController: UIViewController {
    
    fileprivate lazy var lottieView: LottieExtraView = {
        return LottieExtraView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lottieView)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        lottieView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        lottieView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        lottieView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        lottieView.configAnimation(name: "micro")
        lottieView.play()
        lottieView.loopMode = .loop
        
        /// Test show/hidden keyPath
        lottieView.hidden(keyPath: "能量_电池to用电")
        lottieView.hidden(keyPath: "能量_电池to电网")
        lottieView.hidden(keyPath: "能量_电网to电池")
        lottieView.hidden(keyPath: "能量_电网to用电")

        lottieView.hidden(keyPath: "能量_逆变器to用电")
        lottieView.hidden(keyPath: "能量_逆变器to电网")
        lottieView.hidden(keyPath: "能量_逆变器to电池")

        lottieView.hidden(keyPath: "按钮_电网")
        lottieView.show(keyPath: "**")
        lottieView.show(keyPath: "能量_逆变器to用电")
        
        ///  Test action
        lottieView.addTarget(target: self, action: #selector(gridAction), keyPath: "按钮_电网")
        lottieView.addTarget(target: self, action: #selector(invertAction(_:)), keyPath: "按钮_逆变器")
        lottieView.removeTarget(action: #selector(gridAction), keyPath: "按钮_电网")
        
        /// Test add View
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.text = "测试文字,,, Test label"
        lbl.backgroundColor = UIColor.red
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            lbl.text = "文本内容发生了改变,  Test label"
        }
        lottieView.addView(lbl, keyPath: "文本_逆变器")
        
        let lbl2 = UILabel()
        lbl2.textColor = UIColor.orange
        lbl2.text = "电网文本"
        lbl2.backgroundColor = UIColor.blue
        lbl2.font = UIFont.systemFont(ofSize: 18)
        lbl2.textAlignment = .center
        lbl2.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            lbl2.text = "电网 文本 发生了变化"
        }
        lottieView.addView(lbl2, keyPath: "文本_电网")
        
        /// Test view center
        let position = lottieView.animationView.viewCenter(for: "文本_PCS")
        let viewP = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        viewP.backgroundColor = UIColor.orange
        viewP.center = position
        lottieView.addSubview(viewP)
    }
    
    @objc private func gridAction() {
        print(#function)
    }
    
    @objc private func invertAction(_ sender: LottieExtraView) {
        print(sender)
        print(#function)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

