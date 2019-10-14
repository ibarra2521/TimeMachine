//
//  Loading.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import UIKit

open class Loading {
    
    // MARK: - Properties
    internal static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = .large
    public static var baseBackColor = UIColor.black.withAlphaComponent(0.2)
    public static var baseColor = UIColor.black
    
    // MARK: - Public methods
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        if spinner == nil {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.backgroundColor = backColor
            spinner?.style = style
            spinner?.color = baseColor
            window?.addSubview(spinner ?? UIView())
            spinner?.startAnimating()
        }
    }
    
    public static func stop() {
        if spinner != nil {
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
    
    @objc private static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
