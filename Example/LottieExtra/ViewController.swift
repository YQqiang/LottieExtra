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
        lottieView.animationView.loopMode = .loop
        lottieView.hidden(keyPath: "能量_电池to用电")
        lottieView.hidden(keyPath: "能量_电池to电网")
        lottieView.hidden(keyPath: "能量_电网to电池")
        lottieView.hidden(keyPath: "能量_电网to用电")

        lottieView.hidden(keyPath: "能量_逆变器to用电")
        lottieView.hidden(keyPath: "能量_逆变器to电网")
        lottieView.hidden(keyPath: "能量_逆变器to电池")

        lottieView.hidden(keyPath: "按钮_电网")
        
        lottieView.show(keyPath: "**")
        
        lottieView.animationView.logHierarchyKeypaths()
//
        lottieView.show(keyPath: "能量_逆变器to用电")
//        lottieView.show(keyPath: "能量_逆变器to电网")
        
//        lottieView.hidden(keyPath: "能量_逆变器to电池")
//        lottieView.show(keyPath: "*")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

