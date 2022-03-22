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
    private var crash: UIImageView!
    private var centerPosition: CGRect!
    private var informationView: UIView!
    private var informationLabel: UILabel!
    private var startCarLocation: CGRect!
    private var startLabel: UILabel!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    var carData: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        startLabelSettings()
        markupSettings()
        carItemSettings()
        informationViewSettings()
        informationLabelSettings()
        panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onCar))
        view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: []) {
            self.informationView.frame = self.locations(position: "infoAnimation1")
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
                self.informationView.frame = self.locations(position: "infoAnimation2")
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
        
//        let position = markupCenterSecond.layer.presentation()!.frame
//        print(position)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: []) {
            self.startLabel.frame = self.locations(position: "startAnimation")
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, options: []) {
            self.informationView.frame = self.locations(position: "infoAnimation3")
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.markupCenter.frame = self.locations(position: "centerAnimation")
        }
        
        UIView.animate(withDuration: 1.3, delay: 0.5, options: [.repeat]) {
            self.markupCenterSecond.frame = self.locations(position: "centerSecondAnimation")
        }
        if carItem.frame.intersects(markupLeftSide.frame)
        || carItem.frame.intersects(markupRightSide.frame)
        || carItem.frame.intersects(markupCenterSecond.layer.presentation()!.frame) {
            UIView.animate(withDuration: 0.1, delay: 0, options: []) {
                self.crash.frame = CGRect(x: self.view.bounds.midX - 200, y: self.view.bounds.midX, width: 400, height: 300)
            }
            self.startLabel.frame = self.locations(position: "start")
            self.startLabel.backgroundColor = .red
            let attributesStart: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                                  .foregroundColor: UIColor.white,
                                                                  .font: UIFont.systemFont(ofSize: 40,
                                                                                           weight: .bold)]
            self.startLabel.attributedText = NSMutableAttributedString(string: "Y O U   L O O S E !",
                                                                  attributes: attributesStart)
            view.removeGestureRecognizer(panGestureRecognizer)
        }
//            print("left contact")
//        } else if carItem.frame.intersects(markupRightSide.frame) {
//            print("right contact")
//        } else if carItem.frame.intersects(markupCenterSecond.layer.presentation()!.frame) {
//            print("BEBRA")
//        }
    }
    //MARK: - Private Functions
    //MARK: -
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
        carItem.image = UIImage(named: carData)
        carItem.contentMode = .scaleAspectFit
        carItem.frame = locations(position: "car")
        view.addSubview(carItem)
        
        crash = UIImageView()
        crash.image = UIImage(named: "crash")
        crash.contentMode = .scaleAspectFit
        crash.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        view.addSubview(crash)
    }
    
    private func informationViewSettings() {
        informationView = UIView()
        informationView.frame = locations(position: "infoView")
        informationView.applyCornerRadius(radius: 20)
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
        startLabel = UILabel()
        startLabel = UILabel(frame: locations(position: "start"))
        startLabel.backgroundColor = .white
        startLabel.textAlignment = .center
        let attributesStart: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                              .foregroundColor: UIColor.systemGray,
                                                              .font: UIFont.systemFont(ofSize: 40,
                                                                                       weight: .light)]
        startLabel.attributedText = NSMutableAttributedString(string: "S    T    A    R    T",
                                                              attributes: attributesStart)
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
        let informationViewAnimation1 = CGRect(x: UIScreen.main.bounds.midX - informationViewWidth / 2 - 20,
                                              y: UIScreen.main.bounds.midY - informationViewHeight,
                                              width: informationViewWidth,
                                              height: informationViewHeight)
        let informationViewAnimation2 = CGRect(x: UIScreen.main.bounds.midX - informationViewWidth / 2 + 20,
                                               y: UIScreen.main.bounds.midY - informationViewHeight,
                                               width: informationViewWidth,
                                               height: informationViewHeight)
        let informationViewAnimation3 = CGRect(x: UIScreen.main.bounds.midX - informationViewWidth / 2,
                                               y: UIScreen.main.bounds.midY + informationViewHeight * 25,
                                               width: informationViewWidth,
                                               height: informationViewHeight)
        let startLabelAnimation = CGRect(x: UIScreen.main.bounds.midX - startLabelWidth / 2,
                                         y: UIScreen.main.bounds.midY + startLabelHeight * 22,
                                         width: startLabelWidth,
                                         height: startLabelHeight)
        let markupCenterAnimation = CGRect(x: UIScreen.main.bounds.midX - markupWidth / 2,
                                           y: UIScreen.main.bounds.maxY + markupHeight * 0.6,
                                           width: markupWidth,
                                           height: markupHeight)
        let markupCenterSecondAnimation = CGRect(x: UIScreen.main.bounds.midX - markupWidth / 2,
                                                 y: UIScreen.main.bounds.maxY + markupHeight * 1.6,
                                                 width: markupWidth,
                                                 height: markupHeight * 2)
        
        result = position == "center" ? markupCenterLocation
        : position == "center2" ? markupCenterSecondLoaction
        : position == "left" ? markupLeftLoaction
        : position == "right" ? markupRightLocation
        : position == "car" ? carLocation
        : position == "infoView" ? informationViewLocation
        : position == "start" ? startLabelLocation
        : position == "infoAnimation1" ? informationViewAnimation1
        : position == "infoAnimation2" ? informationViewAnimation2
        : position == "infoAnimation3" ? informationViewAnimation3
        : position == "startAnimation" ? startLabelAnimation
        : position == "centerAnimation" ? markupCenterAnimation
        : markupCenterSecondAnimation
        
        return result
    }
}
