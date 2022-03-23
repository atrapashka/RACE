
import Foundation
import UIKit

class PointManager {
    static let shared = PointManager()
    
    let markupWidth: CGFloat = 10
    let markupHeight: CGFloat = 500
    let carWidth: CGFloat = 70
    let carHeight: CGFloat = 130
    let infoViewWidth: CGFloat = 250
    let infoViewHeight: CGFloat = 40
    let startLabelWidth: CGFloat = 400
    let startLabelHeight: CGFloat = 45
    
    func updatePoint(view: UIView, position: points) -> CGRect {
        switch position {
        case points.markupCenterInitialPoint:
            return markupCenterInitial(view: view)
        case points.markupCenterSecondInitialPoint:
            return markupCenterSecondInitial(view: view)
        case points.markupLeftInitialPoint:
            return markupLeftInitial(view: view)
        case points.markupRightInitialPoint:
            return markupRightInitial(view: view)
        case points.infoViewInitialPoint:
            return infoViewInitial(view: view)
        case points.startLabelInitialPoint:
            return startLabelInitial(view: view)
        case points.infoViewAnimationPointOne:
            return updateInfoViewPointOne(view: view)
        case points.infoViewAnimationPointTwo:
            return updateInfoViewPointTwo(view: view)
        case points.infoViewAnimationPointThree:
            return updateInfoViewPointThree(view: view)
        case points.startLabelAnimationPoint:
            return updateStartLabelPoint(view: view)
        case points.markupCenterAnimationPoint:
            return updateMarkupCenterPoint(view: view)
        case points.markupCenterSecondAnimationPoint:
            return updateMarkupCenterSecondPoint(view: view)
        }
    }
    
    func markupCenterInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.midY - markupHeight / 1.5,
                      width: markupWidth,
                      height: markupHeight)
    }
    
    func markupCenterSecondInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.minY - markupHeight * 2.5,
                      width: markupWidth,
                      height: markupHeight * 2)
    }
    
    func markupLeftInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minX + markupWidth / 2,
                      y: view.bounds.minY,
                      width: markupWidth,
                      height: view.bounds.height)
    }
    
    func markupRightInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX - markupWidth * 1.5,
                      y: view.bounds.minY,
                      width: markupWidth,
                      height: view.bounds.height)
    }
    
    func carInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - carWidth / 2,
                      y: view.bounds.maxY - carHeight * 1.5,
                      width: carWidth,
                      height: carHeight)
    }
    
    func infoViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2,
                      y: view.bounds.midY - infoViewHeight,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func startLabelInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - startLabelWidth / 2,
                      y: view.bounds.midY + startLabelHeight * 4,
                      width: startLabelWidth,
                      height: startLabelHeight)
    }
    
    func updateInfoViewPointOne(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2 - 20,
                      y: view.bounds.midY - infoViewHeight,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func updateInfoViewPointTwo(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2 + 20,
                      y: view.bounds.midY - infoViewHeight,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func updateInfoViewPointThree(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2,
                      y: view.bounds.midY + infoViewHeight * 25,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func updateStartLabelPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - startLabelWidth / 2,
                      y: view.bounds.midY + startLabelHeight * 22,
                      width: startLabelWidth,
                      height: startLabelHeight)
    }
    
    func updateMarkupCenterPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.maxY + markupHeight * 0.6,
                      width: markupWidth,
                      height: markupHeight)
    }
    
    func updateMarkupCenterSecondPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.maxY + markupHeight * 1.6,
                      width: markupWidth,
                      height: markupHeight * 2)
    }
}
