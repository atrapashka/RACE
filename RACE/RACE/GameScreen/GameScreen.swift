//
//  GameScreen.swift
//  RACE
//
//  Created by Alehandro on 10.03.22.
//

import UIKit

class GameScreen: UIViewController {
    
    private var markupCenter: UIView!
    private var markupLeftSide: UIView!
    private var markupRightSide: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        markupSettings()

    }
    
    private func markupSettings() {
        var width: CGFloat = 20
        var height: CGFloat = 200
        
        markupCenter = UIView()
        markupCenter.backgroundColor = .white
        markupCenter.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2,
                              y: UIScreen.main.bounds.midY - height / 2,
                              width: width,
                              height: height)
        
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
    }
}
