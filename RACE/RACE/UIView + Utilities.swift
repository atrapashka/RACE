
import Foundation
import UIKit

extension UIView {
    func applyCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func applyShadow(visibility: Bool) {
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = visibility ? UIScreen.main.scale : 1
    }
}
