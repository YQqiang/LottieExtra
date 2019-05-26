//
//  LottieExtraView.swift
//  LottieExtra
//
//  Created by sungrow on 2019/5/24.
//

import UIKit
import Lottie

private struct LottieExtraAction {
    var keyPath: String
    var rect: CGRect
    var target: Any
    var action: Selector
}

@objcMembers open class LottieExtraView: UIView {

    public private(set) var animationView: AnimationView = {
        let animationV = AnimationView()
        animationV.contentMode = .scaleAspectFit
        return animationV
    }()
    
    fileprivate lazy var actionStack: [LottieExtraAction] = []
    
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
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first else {
            return
        }
        let point = touch.location(in: touch.view)
        guard let convertPoint = animationView.convert(point, toLayerAt: nil) else {
            return
        }
        actionStack.forEach { (lottieAction) in
            if lottieAction.rect.contains(convertPoint) {
                (lottieAction.target as AnyObject).performSelector(onMainThread: lottieAction.action, with: self, waitUntilDone: false)
            }
        }
    }
}

public extension LottieExtraView {
    @objc func configAnimation(name: String, bundle: Bundle = Bundle.main) {
        let animation = Animation.named(name, bundle: bundle, subdirectory: nil, animationCache: nil)
        animationView.animation = animation
    }
}

// MARK: - action
public extension LottieExtraView {
    
    /// 指定keyPath 添加点击事件
    ///
    /// - Parameters:
    ///   - target: 调用者
    ///   - action: 事件
    ///   - keyPath: keyPath
    @objc func addTarget(target: Any, action: Selector, keyPath: String) {
        let lottieActions = actionStack.filter { (lottieAction) -> Bool in
            return action == lottieAction.action && keyPath == lottieAction.keyPath
        }
        guard lottieActions.isEmpty else {
            return
        }
        let rect = animationView.rect(for: keyPath)
        let lottieAction = LottieExtraAction(keyPath: keyPath, rect: rect, target: target, action: action)
        actionStack.append(lottieAction)
    }
    
    /// 移除指定keyPath的点击事件
    ///
    /// - Parameters:
    ///   - action: 事件
    ///   - keyPath: keyPath
    @objc func removeTarget(action: Selector, keyPath: String) {
        actionStack.removeAll { (lottieAction) -> Bool in
            return action == lottieAction.action && keyPath == lottieAction.keyPath
        }
    }
}

// MARK: - add view
public extension LottieExtraView {
    
    /// 在keyPath上添加视图
    ///
    /// - Parameters:
    ///   - view: 视图
    ///   - keyPath: keyPath
    @objc func addView(view: UIView, keyPath: String) {
        let subView = AnimationSubview()
        subView.addSubview(view)
        let kp = AnimationKeypath(keypath: keyPath)
        view.center = animationView.convert(animationView.position(for: keyPath), toLayerAt: kp) ?? CGPoint.zero
        animationView.addSubview(subView, forLayerAt: kp)
    }
}

// MARK: - control
public extension LottieExtraView {
    
    @objc func play() {
        animationView.play()
    }
    
    @objc func pause() {
        animationView.pause()
    }
    
    @objc func stop() {
        animationView.stop()
    }
}

// MARK: - KeyPath Transform Opacity
public extension LottieExtraView {
    
    @objc func show(keyPath: String) {
        show(keyPaths: [keyPath])
    }
    
    @objc func show(keyPaths: [String]) {
        configKeyPath(keyPaths, opacity: 100.0)
    }
    
    @objc func hidden(keyPath: String) {
        hidden(keyPaths: [keyPath])
    }
    
    @objc func hidden(keyPaths: [String]) {
        configKeyPath(keyPaths, opacity: 0.0)
    }
    
    @objc func configKeyPath(_ keyPaths: [String], opacity: CGFloat) {
        keyPaths.forEach { (keyPath) in
            let kp = AnimationKeypath(keypath: "\(keyPath).Transform.Opacity")
            let provider = FloatValueProvider(opacity)
            animationView.setValueProvider(provider, keypath: kp)
        }
    }
}
