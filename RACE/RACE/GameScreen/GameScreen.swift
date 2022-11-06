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
        
        UIView.animate(withDuration: 1, delay: 0, options: []) {
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
        
        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.repeat]) {
            self.markupCenterSecond.frame = CGRect(x: UIScreen.main.bounds.midX - 10 / 2,
                                                   y: UIScreen.main.bounds.maxY + 600,
                                                   width: 10,
                                                   height: 500 * 2)
        }
    }
    
    private func markupSettings() {
        let width: CGFloat = 10
        let height: CGFloat = 500
        
        markupCenter = UIView()
        markupCenter.backgroundColor = .white
        markupCenter.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2,
                                    y: UIScreen.main.bounds.midY - height / 1.5,
                                    width: width,
                                    height: height)
        
        markupCenterSecond = UIView()
        markupCenterSecond.backgroundColor = .white
        markupCenterSecond.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2,
                                          y: UIScreen.main.bounds.minY - height * 2,
                                          width: width,
                                          height: height * 2)
        
        markupLeftSide = UIView()
        markupLeftSide.backgroundColor = .white
        markupLeftSide.frame = CGRect(x: UIScreen.main.bounds.minX + width / 2,
                                      y: UIScreen.main.bounds.minY,
                                      width: width,
                                      height: UIScreen.main.bounds.height)
        
        markupRightSide = UIView()
        markupRightSide.backgroundColor = .white
        markupRightSide.frame = CGRect(x: UIScreen.main.bounds.maxX - width * 1.5,
                                       y: UIScreen.main.bounds.minY,
                                       width: width,
                                       height: UIScreen.main.bounds.height)
        
        view.addSubview(markupLeftSide)
        view.addSubview(markupRightSide)
        view.addSubview(markupCenter)
        view.addSubview(markupCenterSecond)
    }
    
    private func carItemSettings() {
        let width: CGFloat = 70
        let height: CGFloat = 130
        carItem = UIImageView()
        carItem.image = UIImage(named: "car1")
        carItem.contentMode = .scaleAspectFit
        carItem.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2, y: UIScreen.main.bounds.maxY - height * 1.5, width: width, height: height)
        view.addSubview(carItem)
    }
    
    private func informationViewSettings() {
        let width: CGFloat = 250
        let height: CGFloat = 40
        informationView = UIView()
        informationView.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2,
                                       y: UIScreen.main.bounds.midY - height,
                                       width: width,
                                       height: height)
        informationView.layer.cornerRadius = height / 2
        informationView.backgroundColor = .white
        view.addSubview(informationView)
    }
    
    private func informationLabelSettings() {
        let width: CGFloat = 200
        let height: CGFloat = 50
        let firstText = "← MOVE CAR TO →"
        
        let attributesMain: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                         .foregroundColor: UIColor.systemGray,
                                                         .font: UIFont.systemFont(ofSize: 22,
                                                                                  weight: .light)]
        centerPosition = CGRect(x: informationView.bounds.midX - width / 2,
                                y: informationView.bounds.midY - height / 2,
                                width: width,
                                height: height)
        informationLabel = UILabel(frame: centerPosition)
        informationLabel.attributedText = NSMutableAttributedString(string: firstText,
                                                                attributes: attributesMain)
        informationLabel.textAlignment = .center
        informationView.addSubview(informationLabel)
    }
    
    private func startLabelSettings() {
        var width: CGFloat = 400
        var height: CGFloat = 45
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
}
