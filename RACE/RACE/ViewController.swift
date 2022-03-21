//
//  ViewController.swift
//  RACE
//
//  Created by Alehandro on 10.03.22.
//

import UIKit



class ViewController: UIViewController {
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var blurViewSecond: UIView!
    @IBOutlet weak var blurViewThird: UIView!
    @IBOutlet weak var blurViewFourth: UIView!
    @IBOutlet weak var mainBlurView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        title = "Swipe to choose your car ->"
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
//                                                                   .font: UIFont.systemFont(ofSize: 20,
//                                                                                            weight: .light)]
        let buttonBurger = UIButton()
        buttonBurger.addTarget(self, action: #selector(onBurger), for: .touchUpInside)
        buttonBurger.setImage(UIImage(named: "burgerButton"), for: .normal)
        buttonBurger.bounds.size = CGSize(width: 1, height: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBurger)
        
        addBlurView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        blurElementsSettings()
    }
    
    @IBAction func onBurnoutButon(_ sender: Any) {
        transitToGameScreen()
    }
    
    @objc private func onBurger() {
        
    }
    
    private func blurElementsSettings() {
        cornerRadius()
        
        blurView.frame = locations(position: "blur")
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurView.frame = self.locations(position: "blurAnimation")
        }
        
        blurViewSecond.frame = locations(position: "blurSecond")
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewSecond.frame = self.locations(position: "blurSecondAnimation")
        }
        
        blurViewThird.frame = locations(position: "blurThird")
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewThird.frame = self.locations(position: "blurThirdAnimation")
        }
        
        blurViewFourth.frame = locations(position: "blurFourth")
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewFourth.frame = self.locations(position: "blurFourthAnimation")
        }
    }
    
    private func locations (position: String) -> CGRect {
        var result: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let width: CGFloat = 500
        let height: CGFloat = 500
        
        let blurViewLocation = CGRect(x: view.bounds.midX - width,
                                      y: view.bounds.midY - height * 1.5,
                                      width: width,
                                      height: height)
        let blurViewAnimation = CGRect(x: view.bounds.midX + width / 4,
                                       y: view.bounds.midY - height * 1.5,
                                       width: width,
                                       height: height)
        let blurViewSecondLocation = CGRect(x: view.bounds.midX + width / 4,
                                            y: view.bounds.midY - height,
                                            width: width,
                                            height: height)
        let blurViewSecondAnimation = CGRect(x: view.bounds.midX - width,
                                             y: view.bounds.midY - height,
                                             width: width,
                                             height: height)
        let blurViewThirdLocation = CGRect(x: view.bounds.midX - width,
                                           y: view.bounds.midY - height / 2,
                                            width: width,
                                            height: height)
        let blurViewThirdAnimation = CGRect(x: view.bounds.midX + width / 4,
                                            y: view.bounds.midY - height / 2,
                                             width: width,
                                             height: height)
        let blurViewFourthLocation = CGRect(x: view.bounds.midX + width / 4,
                                            y: UIScreen.main.bounds.midY,
                                            width: width,
                                            height: height)
        let blurViewFourthAnimation = CGRect(x: view.bounds.midX - width,
                                             y: view.bounds.midY,
                                             width: width,
                                             height: height)
        
        result = position == "blur" ? blurViewLocation
        : position == "blurAnimation" ? blurViewAnimation
        : position == "blurSecond" ? blurViewSecondLocation
        : position == "blurSecondAnimation" ? blurViewSecondAnimation
        : position == "blurThird" ? blurViewThirdLocation
        : position == "blurThirdAnimation" ? blurViewThirdAnimation
        : position == "blurFourth" ? blurViewFourthLocation
        : blurViewFourthAnimation
        
        return result
    }
    
    private func cornerRadius() {
        let radius: CGFloat = 250
        blurView.applyCornerRadius(radius: radius)
        blurViewSecond.applyCornerRadius(radius: radius)
        blurViewThird.applyCornerRadius(radius: radius)
        blurViewFourth.applyCornerRadius(radius: radius)
    }
    
    private func addBlurView() {
        let blur = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.frame = mainBlurView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainBlurView.addSubview(blurEffectView)
    }
    
    func transitToGameScreen() {
        let storyboard = UIStoryboard.init(name: "GameScreen", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController() as! GameScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

