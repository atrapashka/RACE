//
//  GameScreen.swift
//  RACE
//
//  Created by Alehandro on 10.03.22.
//

import UIKit

class GameScreen: UIViewController {
    
    private var markupCenter: UIView!
    private var markupCenterSecond: UIView!
    private var markupLeftSide: UIView!
    private var markupLeftSideSecond: UIView!
    private var markupRightSide: UIView!
    private var markupRightSideSecond: UIView!
    private var carItem: UIImageView!
    private var centerPosition: CGRect!
    private var informationView: UIView!
    private var informationLabel: UILabel!
    private var startCarLocation: CGRect!
    private var startLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        startLabelSettings()
        markupSettings()
        carItemSettings()
        informationViewSettings()
        informationLabelSettings()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onCar))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startCarLocation = CGRect(x: UIScreen.main.bounds.midX - 70 / 2,
                                  y: UIScreen.main.bounds.maxY - 130 * 1.5,
                                  width: 70,
                                  height: 130)
        let width: CGFloat = 250
        let height: CGFloat = 40
        UIView.animate(withDuration: 0.5, delay: 0.3, options: []) {
            self.informationView.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2 - 20,
                                         y: UIScreen.main.bounds.midY - height,
                                         width: width,
                                         height: height)
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
                self.informationView.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2 + 20,
                                             y: UIScreen.main.bounds.midY - height,
                                             width: width,
                                             height: height)
           }
        }
        
        UIView.animate(withDuration: 0.5, delay: 4, options: []) {
            self.informationLabel.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
                let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemGray,
                                                                 .font: UIFont.systemFont(ofSize: 22,
                                                                                          weight: .light)]
                self.informationLabel.alpha = 1
                self.informationLabel.attributedText = NSAttributedString(string: "RACE▷▷▷",
                                                                          attributes: attributes)
            }
        }
    }
    
    @objc func onCar(gesture: UIPanGestureRecognizer) {
        let width: CGFloat = 70
        let height: CGFloat = 130
        let location = gesture.location(in: view)
        let x = location.x
        let y = location.y
        carItem.frame = CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: []) {
            self.startLabel.frame = CGRect(x: UIScreen.main.bounds.midX - 400 / 2,
                                           y: UIScreen.main.bounds.midY + 1000,
                                           width: 400,
                                           height: 45)
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, options: []) {
            self.informationView.frame = CGRect(x: UIScreen.main.bounds.midX - 250 / 2,
                                           y: UIScreen.main.bounds.midY + 1000,
                                           width: 250,
                                           height: 40)
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.markupCenter.frame = CGRect(x: UIScreen.main.bounds.midX - 10 / 2,
                                             y: UIScreen.main.bounds.maxY + 300,
                                             width: 10,
                                             height: 500)
        }
        
        UIView.animate(withDuration: 1.3, delay: 0.5, options: [.repeat]) {
            self.markupCenterSecond.frame = CGRect(x: UIScreen.main.bounds.midX - 10 / 2,
                                                   y: UIScreen.main.bounds.maxY + 800,
                                                   width: 10,
                                                   height: 500 * 2)
        }
    }
    
    private func markupSettings() {
        markupCenter = UIView()
        markupCenter.backgroundColor = .white
        markupCenter.frame = locations(position: "center")
        
        markupCenterSecond = UIView()
        markupCenterSecond.backgroundColor = .white
        markupCenterSecond.frame = locations(position: "center2")
        
        markupLeftSide = UIView()
        markupLeftSide.backgroundColor = .white
        markupLeftSide.frame = locations(position: "left")
        
        markupRightSide = UIView()
        markupRightSide.backgroundColor = .white
        markupRightSide.frame = locations(position: "right")
        
        view.addSubview(markupLeftSide)
        view.addSubview(markupRightSide)
        view.addSubview(markupCenter)
        view.addSubview(markupCenterSecond)
    }
    
    private func carItemSettings() {
        carItem = UIImageView()
        carItem.image = UIImage(named: "car1")
        carItem.contentMode = .scaleAspectFit
        carItem.frame = locations(position: "car")
        view.addSubview(carItem)
    }
    
    private func informationViewSettings() {
        informationView = UIView()
        informationView.frame = locations(position: "infoView")
        informationView.layer.cornerRadius = 40 / 2
        informationView.backgroundColor = .white
        view.addSubview(informationView)
    }
    
    private func informationLabelSettings() {
        let informationLabelWidth: CGFloat = 200
        let informationLabelHeight: CGFloat = 50
        let firstText = "← MOVE CAR TO →"
        let attributesMain: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                         .foregroundColor: UIColor.systemGray,
                                                         .font: UIFont.systemFont(ofSize: 22,
                                                                                  weight: .light)]
        informationLabel = UILabel(frame: CGRect(x: informationView.bounds.midX - informationLabelWidth / 2,
                                                 y: informationView.bounds.midY - informationLabelHeight / 2,
                                                 width: informationLabelWidth,
                                                 height: informationLabelHeight))
        informationLabel.attributedText = NSMutableAttributedString(string: firstText,
                                                                attributes: attributesMain)
        informationLabel.textAlignment = .center
        informationView.addSubview(informationLabel)
    }
    
    private func startLabelSettings() {
        let width: CGFloat = 400
        let height: CGFloat = 45
        startLabel = UILabel()
        startLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.midX - width / 2,
                                               y: UIScreen.main.bounds.midY + height * 4,
                                               width: width,
                                               height: height))
        let attributesStart: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                         .foregroundColor: UIColor.systemGray,
                                                              .font: UIFont.systemFont(ofSize: 40,
                                                                                       weight: .light)]
        startLabel.backgroundColor = .white
        startLabel.attributedText = NSMutableAttributedString(string: "S    T    A    R    T",
                                                              attributes: attributesStart)
        startLabel.textAlignment = .center
        view.addSubview(startLabel)
    }
    
    private func locations(position: String) -> CGRect {
        var result: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let markupWidth: CGFloat = 10
        let markupHeight: CGFloat = 500
        let carWidth: CGFloat = 70
        let carHeight: CGFloat = 130
        let informationViewWidth: CGFloat = 250
        let informationViewHeight: CGFloat = 40
        let startLabelWidth: CGFloat = 400
        let startLabelHeight: CGFloat = 45
        
        let markupCenterLocation = CGRect(x: UIScreen.main.bounds.midX - markupWidth / 2,
                                          y: UIScreen.main.bounds.midY - markupHeight / 1.5,
                                          width: markupWidth,
                                          height: markupHeight)
        let markupCenterSecondLoaction = CGRect(x: UIScreen.main.bounds.midX - markupWidth / 2,
                                                y: UIScreen.main.bounds.minY - markupHeight * 2.5,
                                                width: markupWidth,
                                                height: markupHeight * 2)
        let markupLeftLoaction = CGRect(x: UIScreen.main.bounds.minX + markupWidth / 2,
                                        y: UIScreen.main.bounds.minY,
                                        width: markupWidth,
                                        height: UIScreen.main.bounds.height)
        let markupRightLocation = CGRect(x: UIScreen.main.bounds.maxX - markupWidth * 1.5,
                                         y: UIScreen.main.bounds.minY,
                                         width: markupWidth,
                                         height: UIScreen.main.bounds.height)
        let carLocation = CGRect(x: UIScreen.main.bounds.midX - carWidth / 2,
                                 y: UIScreen.main.bounds.maxY - carHeight * 1.5,
                                 width: carWidth,
                                 height: carHeight)
        let informationViewLocation = CGRect(x: UIScreen.main.bounds.midX - informationViewWidth / 2,
                                             y: UIScreen.main.bounds.midY - informationViewHeight,
                                             width: informationViewWidth,
                                             height: informationViewHeight)
        let startLabelLocation = CGRect(x: UIScreen.main.bounds.midX - startLabelWidth / 2,
                                        y: UIScreen.main.bounds.midY + startLabelHeight * 4,
                                        width: startLabelWidth,
                                        height: startLabelHeight)
        
        result = position == "center" ? markupCenterLocation
        : position == "center2" ? markupCenterSecondLoaction
        : position == "left" ? markupLeftLoaction
        : position == "right" ? markupRightLocation
        : position == "car" ? carLocation
        : position == "infoView" ? informationViewLocation
        : startLabelLocation
        
        return result
    }
}
