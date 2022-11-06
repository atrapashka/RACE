//
//  ViewController.swift
//  RACE
//
//  Created by Alehandro on 10.03.22.
//

import UIKit

private var width: CGFloat = 500
private var height: CGFloat = 500

class ViewController: UIViewController {
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var blurViewSecond: UIView!
    @IBOutlet weak var blurViewThird: UIView!
    @IBOutlet weak var blurViewFourth: UIView!
    @IBOutlet weak var mainBlurView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addBlurView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        blurElementsSettings()
    }
    
    @IBAction func onBurnoutButon(_ sender: Any) {
        transitToGameScreen()
    }
    
    private func blurElementsSettings() {
        blurView.frame = CGRect(x: UIScreen.main.bounds.midX - width,
                                y: UIScreen.main.bounds.midY - height * 1.5,
                                width: width,
                                height: height)
        blurView.layer.cornerRadius = width / 2
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurView.frame = CGRect(x: UIScreen.main.bounds.midX + width / 4,
                                         y: UIScreen.main.bounds.midY - height * 1.5,
                                         width: width,
                                         height: height)
        }
        
        blurViewSecond.frame = CGRect(x: UIScreen.main.bounds.midX + width / 4,
                                      y: UIScreen.main.bounds.midY - height,
                                      width: width,
                                      height: height)
        blurViewSecond.layer.cornerRadius = width / 2
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewSecond.frame = CGRect(x: UIScreen.main.bounds.midX - width,
                                               y: UIScreen.main.bounds.midY - height,
                                               width: width,
                                               height: height)
        }
        
        blurViewThird.frame = CGRect(x: UIScreen.main.bounds.midX - width,
                                     y: UIScreen.main.bounds.midY - height / 2,
                                      width: width,
                                      height: height)
        blurViewThird.layer.cornerRadius = width / 2
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewThird.frame = CGRect(x: UIScreen.main.bounds.midX + width / 4,
                                              y: UIScreen.main.bounds.midY - height / 2,
                                               width: width,
                                               height: height)
        }
        
        blurViewFourth.frame = CGRect(x: UIScreen.main.bounds.midX + width / 4,
                                      y: UIScreen.main.bounds.midY,
                                      width: width,
                                      height: height)
        blurViewFourth.layer.cornerRadius = width / 2
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewFourth.frame = CGRect(x: UIScreen.main.bounds.midX - width,
                                               y: UIScreen.main.bounds.midY,
                                               width: width,
                                               height: height)
        }
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

