//
//  LottieExtraView.swift
//  LottieExtra
//
//  Created by sungrow on 2019/5/24.
//

import UIKit
import Lottie

@objcMembers open class LottieExtraView: UIView {

    public private(set) var animationView: AnimationView = {
        let animationV = AnimationView()
        animationV.contentMode = .scaleAspectFit
        return animationV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createView()
    }
    
    private func createView() {
        addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        animationView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        animationView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
}

extension LottieExtraView {
    @objc public func configAnimation(name: String, bundle: Bundle = Bundle.main) {
        let animation = Animation.named(name, bundle: bundle, subdirectory: nil, animationCache: nil)
        animationView.animation = animation
    }
}

// MARK: - control
extension LottieExtraView {
    
    @objc public func play() {
        animationView.play()
    }
    
    @objc public func pause() {
        animationView.pause()
    }
    
    @objc public func stop() {
        animationView.stop()
    }
}

// MARK: - KeyPath Transform Opacity
extension LottieExtraView {
    
    @objc public func show(keyPath: String) {
        show(keyPaths: [keyPath])
    }
    
    @objc public func show(keyPaths: [String]) {
        configKeyPath(keyPaths, opacity: 100.0)
    }
    
    @objc public func hidden(keyPath: String) {
        hidden(keyPaths: [keyPath])
    }
    
    @objc public func hidden(keyPaths: [String]) {
        configKeyPath(keyPaths, opacity: 0.0)
    }
    
    @objc public func configKeyPath(_ keyPaths: [String], opacity: CGFloat) {
        keyPaths.forEach { (keyPath) in
            let kp = AnimationKeypath(keypath: "\(keyPath).Transform.Opacity")
            let provider = FloatValueProvider(opacity)
            animationView.setValueProvider(provider, keypath: kp)
        }
    }
}
