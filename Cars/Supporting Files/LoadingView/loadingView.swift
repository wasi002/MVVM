//
//  loadingView.swift
//  Cars
//
//  Created by Muhammad Waseem on 25/08/2019.
//  Copyright © 2019 Muhammad Waseem. All rights reserved.
//

import UIKit

class loadingView: UIView {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var animateView: AnimateloadingView!
    @IBOutlet var containerView: UIView!
    
    public var loadingViewMessage : String! {
        didSet {
            messageLabel.text = loadingViewMessage
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        containerView.addBlurAreaForLoading(area: containerView.bounds, style: .dark)
        containerView.bringSubviewToFront(messageLabel)
    }
    public func startAnimation(){
        if animateView.isAnimating {return}
        animateView.startAnimating()
    }
    public func stopAnimation(){
        animateView.stopAnimating()
    }
}
extension UIView {
    func addBlurAreaForLoading(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        self.insertSubview(container, at: 1)
    }
}
