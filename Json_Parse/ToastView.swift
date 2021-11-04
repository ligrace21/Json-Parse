//
//  ToastView.swift
//  Json_Parse
//
//  Created by user on 10/6/21.
//

import UIKit

//to show errors or warnings
class ToastView: UIView {
    
    private static let hLabelGap: CGFloat = 40.0
    private static let vLabelGap: CGFloat = 20.0
    private static let hToastGap: CGFloat = 20.0
    private static let vToastGap: CGFloat = 20.0
    
    private var textLabel: UILabel!
    
    static func showInParent(_ parentView: UIView, _ text: String, duration: Double = 3.0) {
        let labelFrame = CGRect(x: parentView.frame.origin.x + hLabelGap,
                                y: parentView.frame.origin.y + vLabelGap,
                                width: parentView.frame.width - 2 * hLabelGap,
                                height: parentView.frame.height - 2 * vLabelGap)
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = text
        label.backgroundColor = UIColor.systemRed
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.frame = labelFrame
        label.sizeToFit()
        
        let toast = ToastView()
        toast.textLabel = label
        toast.addSubview(label)
        toast.frame = CGRect(x: label.frame.origin.x - hToastGap,
                             y: label.frame.origin.y - vToastGap,
                             width: label.frame.width + 2 * hToastGap,
                             height: label.frame.height + 2 * vToastGap)
        toast.backgroundColor = UIColor.systemRed
        toast.alpha = 0.0
        toast.layer.cornerRadius = 5.0
        toast.center = parentView.center
        label.center = CGPoint(x: toast.frame.size.width / 2, y: toast.frame.size.height / 2)
        
        parentView.addSubview(toast)
        
        UIView.animate(withDuration: 0.5, animations: {
            toast.alpha = 1.0
            label.alpha = 1.0
        })
        
        toast.perform(#selector(hideSelf), with: nil, afterDelay: duration)
    }
    
    @objc private func hideSelf() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
            self.textLabel.alpha = 0.0
        }, completion: { t in self.removeFromSuperview() })
    }
}

