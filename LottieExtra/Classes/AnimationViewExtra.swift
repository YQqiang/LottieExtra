//
//  AnimationViewExtra.swift
//  LottieExtra
//
//  Created by sungrow on 2019/5/25.
//

import Lottie

public extension AnimationView {
    
    /// 获取指定keyPath的位置
    ///
    /// - Parameter keyPath: keyPath
    /// - Returns: 位置
    @objc func position(for keyPath: String) -> CGPoint {
        let kp = AnimationKeypath(keypath: "\(keyPath).Transform.Position")
        guard let vector = getValue(for: kp, atFrame: nil) as? Vector3D  else {
            return CGPoint.zero
        }
        return CGPoint(x: vector.sizeValue.width, y: vector.sizeValue.height)
    }
    
    /// 获取指定keyPath的锚点
    ///
    /// - Parameter keyPath: keyPath
    /// - Returns: 锚点
    @objc func anchorPoint(for keyPath: String) -> CGPoint {
        let kp = AnimationKeypath(keypath: "\(keyPath).Transform.Anchor Point")
        guard let vector = getValue(for: kp, atFrame: nil) as? Vector3D  else {
            return CGPoint.zero
        }
        return CGPoint(x: vector.sizeValue.width, y: vector.sizeValue.height)
    }
    
    /// 获取指定keyPath的rect (锚点为中心点时可用)
    ///
    /// - Parameter keyPath: keyPath
    /// - Returns: rect
    @objc func rect(for keyPath: String) -> CGRect {
        let anchor = anchorPoint(for: keyPath)
        let posi = position(for: keyPath)
        let rect = CGRect(x: posi.x - anchor.x, y: posi.y - anchor.y, width: anchor.x * 2, height: anchor.y * 2)
        return rect
    }
    
    /// 获取指定keyPath的旋转角度
    ///
    /// - Parameter keyPath: keyPath
    /// - Returns: 旋转角度
    @objc func rotation(for keyPath: String) -> Double {
        let kp = AnimationKeypath(keypath: "\(keyPath).Transform.Rotation")
        guard let vector = getValue(for: kp, atFrame: nil) as? Vector1D  else {
            return Double.zero
        }
        return Mirror(reflecting: vector).children.first?.value as? Double ?? Double.zero
    }
    
    /// 获取指定keyPath的不透明度
    ///
    /// - Parameter keyPath: keyPath
    /// - Returns: 不透明度
    @objc func opacity(for keyPath: String) -> Double {
        let kp = AnimationKeypath(keypath: "\(keyPath).Transform.Opacity")
        guard let vector = getValue(for: kp, atFrame: nil) as? Vector1D  else {
            return Double.zero
        }
        return Mirror(reflecting: vector).children.first?.value as? Double ?? Double.zero
    }
}

public extension AnimationView {
    
    @objc func viewCenter(for keyPath: String) -> CGPoint {
        let animationP = position(for: keyPath)
        let scale = coordinateScale
        let offset = coordinateOffset
        return CGPoint(x: scale * (animationP.x + offset.y), y: scale * (animationP.y + offset.x))
    }
    
    @objc var coordinateScale: CGFloat {
        return coordinateScaleAndOffset().scale
    }
    
    @objc var coordinateOffset: CGPoint {
        return coordinateScaleAndOffset().offset
    }
    
    func coordinateScaleAndOffset() -> (scale: CGFloat, offset: CGPoint) {
        var scale: CGFloat = 1.0
        var offset = CGPoint.zero
        guard let animation = animation else { return (scale, offset) }
        let canvasW = animation.bounds.width
        let canvasH = animation.bounds.height
        
        let viewW = bounds.size.width
        let viewH = bounds.size.height
        
        if (viewW / viewH > canvasW / canvasH) {
            scale = viewH / canvasH;
            offset = CGPoint(x: 0, y: (viewW / scale - canvasW) / 2)
        } else {
            scale = viewW / canvasW;
            offset = CGPoint(x: (viewH / scale - canvasH) / 2, y: 0)
        }
        return (scale, offset)
    }
}
