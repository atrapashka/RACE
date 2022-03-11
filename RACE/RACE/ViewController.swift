//
//  ViewController.swift
//  RACE
//
//  Created by Alehandro on 10.03.22.
//

import UIKit

private var width: CGFloat = 350
private var height: CGFloat = 350
private var customView: UIView!

class ViewController: UIViewController {
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var mainBlurView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        blurElementsSettings()
        
    }
    
    private func blurElementsSettings() {
        blurView.frame = CGRect(x: UIScreen.main.bounds.midX - width,
                                y: UIScreen.main.bounds.midY - height * 1.5,
                                              width: width,
                                              height: height)
        blurView.layer.cornerRadius = width / 2
        
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurView.frame = CGRect(x: UIScreen.main.bounds.midX + width / 4,
                                         y: UIScreen.main.bounds.midY - height * 1.5,
                                      width: width,
                                      height: height)
        }
    }
    
    private func addBlurView() {
        
    }


}

