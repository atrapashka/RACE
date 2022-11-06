
import UIKit

class SettingsScreen: UIViewController {
    private var customViewTop: UIView!
    private var customViewSide: UIView!
    private var customViewBottom: UIView!
    private var blurView: UIView!
    private var backgroundButton: UIButton!
    private var obstacleButton: UIButton!
    private var difficultyButton: UIButton!
    private var confirmButton: UIButton!
    private var backgroundView: UIView!
    private var obstacleView: UIView!
    private var difficultyView: UIView!
    private var topLabel: UILabel!
    private var middleLabel: UILabel!
    private var bottomLabel: UILabel!
    private var choiseLabel: UILabel!
    private var labelArray: [UILabel]!
    private var tapTopGesture: UITapGestureRecognizer!
    private var tapMiddleGesture: UITapGestureRecognizer!
    private var tapBottomGesture: UITapGestureRecognizer!
    private var backgroundChoise: String!
    private var obstacleChoise: String!
    private var difficultyChoise: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTINGS"
        view.backgroundColor = .white
        
        tapTopGesture = UITapGestureRecognizer(target: self, action: #selector(onTopLabel))
        tapMiddleGesture = UITapGestureRecognizer(target: self, action: #selector(onMiddleLabel))
        tapBottomGesture = UITapGestureRecognizer(target: self, action: #selector(onBottomLabel))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundButton = UIButton()
        obstacleButton = UIButton()
        difficultyButton = UIButton()
        backgroundView = UIView()
        obstacleView = UIView()
        difficultyView = UIView()
        confirmButton = UIButton()
        topLabel = UILabel()
        middleLabel = UILabel()
        bottomLabel = UILabel()
        choiseLabel = UILabel()
        
        addCustomViews()
        addBlurView()
        addButton(button: backgroundButton, title: "Change background")
        addButton(button: obstacleButton, title: "Choose obstacles")
        addButton(button: difficultyButton, title: "Set dificulty")
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: []) {
            self.customViewTop.frame = PointManager.shared.updateCustomTopViewAnimation(view: self.view)
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, options: []) {
                self.customViewSide.frame = PointManager.shared.updateCustomViewSideAnimation(view: self.view)
                self.backgroundButton.alpha = 1
                self.obstacleButton.alpha = 1
                self.difficultyButton.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 0, options: []) {
                    self.customViewBottom.frame = PointManager.shared.updateCustomViewBottomAnimation(view: self.view)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.05, delay: 0) {
            self.customViewTop.frame.size = CGSize(width: 0, height: 0)
            self.customViewSide.frame.size = CGSize(width: 0, height: 0)
            self.customViewBottom.frame.size = CGSize(width: 0, height: 0)
        }
    }
    
    //MARK: - Actions
    //MARK: -
    
    @objc private func onChangeBackground() {
        backgroundView.frame = PointManager.shared.backgroundViewInitial(view: view)
        buttonsForSettingsView(view: backgroundView, top: "CARPET", middle: "ROAD", bottom: "WOOD")
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.addSettingsView(settingsView: self.backgroundView, button: self.backgroundButton)
            self.confirmButton.addTarget(self, action: #selector(self.onConfirmBackground), for: .touchUpInside)
            if self.obstacleView.frame == PointManager.shared.obstacleViewAnimation(view: self.view) {
                self.obstacleView.frame = PointManager.shared.obstacleViewInitial(view: self.view)
                self.obstacleButton.alpha = 1
                self.middleLabel.frame = PointManager.shared.middleLabelInitial(view: self.obstacleView)
            } else if self.difficultyView.frame == PointManager.shared.difficultyViewAnimation(view: self.view) {
                self.difficultyView.frame = PointManager.shared.difficultyViewInitial(view: self.view)
                self.difficultyButton.alpha = 1
                self.middleLabel.frame = PointManager.shared.middleLabelInitial(view: self.difficultyView)
            }
        }
    }
    
    @objc private func onConfirmBackground() {
        if choiseLabel.frame == topLabel.frame.offsetBy(dx: -80, dy: 0) {
            backgroundChoise = topLabel.text!
        } else if choiseLabel.frame == middleLabel.frame.offsetBy(dx: -80, dy: 0) {
            backgroundChoise = middleLabel.text!
        } else {
            backgroundChoise = bottomLabel.text!
        }
        
        let backgroundSet: String = backgroundChoise
        UserDefaults.standard.set(backgroundSet, forKey: "BackSet")
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.backgroundView.frame = PointManager.shared.backgroundViewInitial(view: self.view)
            self.backgroundButton.alpha = 1
        }
        confirmButton.removeTarget(self, action: #selector(onConfirmBackground), for: .touchUpInside)
    }
    
    @objc private func onTopLabel(gesture: UITapGestureRecognizer) {
        choiseLabel.frame = topLabel.frame.offsetBy(dx: -80, dy: 0)
        choiseLabel.textColor = .systemGreen
    }
    
    @objc private func onChooseObstacle() {
        obstacleView.frame = PointManager.shared.obstacleViewInitial(view: view)
        buttonsForSettingsView(view: obstacleView, top: "PEPPA", middle: "DEFAULT", bottom: "MUSK")
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.addSettingsView(settingsView: self.obstacleView, button: self.obstacleButton)
            self.confirmButton.addTarget(self, action: #selector(self.onConfirmObstacle), for: .touchUpInside)
            if self.backgroundView.frame == PointManager.shared.backgroundViewAnimation(view: self.view) {
                self.backgroundView.frame = PointManager.shared.backgroundViewInitial(view: self.view)
                self.backgroundButton.alpha = 1
                self.middleLabel.frame = PointManager.shared.middleLabelInitial(view: self.backgroundView)
            } else if self.difficultyView.frame == PointManager.shared.difficultyViewAnimation(view: self.view) {
                self.difficultyView.frame = PointManager.shared.difficultyViewInitial(view: self.view)
                self.difficultyButton.alpha = 1
                self.middleLabel.frame = PointManager.shared.middleLabelInitial(view: self.difficultyView)
            }
        }
    }
    
    @objc private func onConfirmObstacle() {
        if choiseLabel.frame == topLabel.frame.offsetBy(dx: -80, dy: 0) {
            obstacleChoise = topLabel.text!
        } else if choiseLabel.frame == middleLabel.frame.offsetBy(dx: -80, dy: 0) {
            obstacleChoise = middleLabel.text!
        } else {
            obstacleChoise = bottomLabel.text!
        }
        
        let obstacleSet: String = obstacleChoise
        UserDefaults.standard.set(obstacleSet, forKey: "ObstSet")
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.obstacleView.frame = PointManager.shared.obstacleViewInitial(view: self.view)
            self.obstacleButton.alpha = 1
        }
        confirmButton.removeTarget(self, action: #selector(onConfirmObstacle), for: .touchUpInside)
    }
    
    @objc private func onMiddleLabel(gesture: UITapGestureRecognizer) {
        choiseLabel.frame = middleLabel.frame.offsetBy(dx: -80, dy: 0)
        choiseLabel.textColor = .systemGreen
    }
    
    @objc private func onSetDifficulty() {
        difficultyView.frame = PointManager.shared.difficultyViewInitial(view: view)
        buttonsForSettingsView(view: difficultyView, top: "EASY", middle: "NORMAL", bottom: "HARD")
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.addSettingsView(settingsView: self.difficultyView, button: self.difficultyButton)
            self.confirmButton.addTarget(self, action: #selector(self.onConfirmDifficulty), for: .touchUpInside)
            if self.backgroundView.frame == PointManager.shared.backgroundViewAnimation(view: self.view) {
                self.backgroundView.frame = PointManager.shared.backgroundViewInitial(view: self.view)
                self.backgroundButton.alpha = 1
                self.middleLabel.frame = PointManager.shared.middleLabelInitial(view: self.backgroundView)
            } else if self.obstacleView.frame == PointManager.shared.obstacleViewAnimation(view: self.view) {
                self.obstacleView.frame = PointManager.shared.obstacleViewInitial(view: self.view)
                self.obstacleButton.alpha = 1
                self.middleLabel.frame = PointManager.shared.middleLabelInitial(view: self.obstacleView)
            }
        }
    }

    @objc private func onConfirmDifficulty() {
        if choiseLabel.frame == topLabel.frame.offsetBy(dx: -80, dy: 0) {
            difficultyChoise = topLabel.text!
        } else if choiseLabel.frame == middleLabel.frame.offsetBy(dx: -80, dy: 0) {
            difficultyChoise = middleLabel.text!
        } else {
            difficultyChoise = bottomLabel.text!
        }
        
        let difficultySet: String = difficultyChoise
        UserDefaults.standard.set(difficultySet, forKey: "DiffSet")
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.difficultyView.frame = PointManager.shared.difficultyViewInitial(view: self.view)
            self.difficultyButton.alpha = 1
        }
        confirmButton.removeTarget(self, action: #selector(onConfirmDifficulty), for: .touchUpInside)
    }
    
    @objc private func onBottomLabel(gesture: UITapGestureRecognizer) {
        choiseLabel.frame = bottomLabel.frame.offsetBy(dx: -80, dy: 0)
        choiseLabel.textColor = .systemGreen
    }
    
    //MARK: - Private Functions
    //MARK: -
    
    private func addCustomViews() {
        customViewTop = UIView()
        customViewTop.backgroundColor = .systemYellow
        customViewTop.applyCornerRadius(radius: view.bounds.width / 2)
        view.addSubview(customViewTop)
        
        customViewSide = UIView()
        customViewSide.frame = PointManager.shared.customViewSideInitial(view: view)
        customViewSide.backgroundColor = .systemPink
        customViewSide.applyCornerRadius(radius: view.bounds.width / 2)
        view.addSubview(customViewSide)
        
        customViewBottom = UIView()
        customViewBottom.frame = PointManager.shared.customViewBottomInitial(view: view)
        customViewBottom.backgroundColor = .systemOrange
        customViewBottom.applyCornerRadius(radius: view.bounds.width)
        view.addSubview(customViewBottom)
        
    }
    
    private func addBlurView() {
        let blur = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
    }
    
    private func addButton(button: UIButton, title: String) {
        if button == backgroundButton {
            button.frame = PointManager.shared.backgroundButtonInitial(view: view)
            button.addTarget(self, action: #selector(onChangeBackground), for: .touchUpInside)
        } else if button == obstacleButton {
            button.frame = PointManager.shared.obstacleButtonInitial(view: view)
            button.addTarget(self, action: #selector(onChooseObstacle), for: .touchUpInside)
        } else {
            button.frame = PointManager.shared.difficultyButtonInitial(view: view)
            button.addTarget(self, action: #selector(onSetDifficulty), for: .touchUpInside)
        }
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(title, for: .normal)
        button.alpha = 0
        view.addSubview(button)
    }
    
    private func addSettingsView(settingsView: UIView, button: UIButton) {
        button.alpha = 0
        settingsView.backgroundColor = .systemGray5
        settingsView.alpha = 0.6
        settingsView.applyCornerRadius(radius: 35)
        if settingsView == backgroundView {
            settingsView.frame = PointManager.shared.backgroundViewAnimation(view: view)
        } else if settingsView == obstacleView {
            settingsView.frame = PointManager.shared.obstacleViewAnimation(view: view)
        } else {
            settingsView.frame = PointManager.shared.difficultyViewAnimation(view: view)
        }
        view.addSubview(settingsView)
    }
    
    private func buttonsForSettingsView(view: UIView, top: String, middle: String, bottom: String) {
        labelArray = [topLabel, middleLabel, bottomLabel]
        confirmButton.contentMode = .scaleAspectFill
        confirmButton.setImage(UIImage(named: "confirm"), for: .normal)
        confirmButton.frame = PointManager.shared.confirmButtonInitial(view: view)
        middleLabel.frame = PointManager.shared.middleLabelInitial(view: view)
        topLabel.frame = middleLabel.frame.offsetBy(dx: 0, dy: -50)
        bottomLabel.frame = middleLabel.frame.offsetBy(dx: 0, dy: 50)
        topLabel.text = top
        middleLabel.text = middle
        bottomLabel.text = bottom
        topLabel.addGestureRecognizer(tapTopGesture)
        middleLabel.addGestureRecognizer(tapMiddleGesture)
        bottomLabel.addGestureRecognizer(tapBottomGesture)
        for i in 0...labelArray.count - 1 {
            labelArray[i].textAlignment = .center
            labelArray[i].font = .systemFont(ofSize: 25, weight: .light)
            labelArray[i].textColor = .black
            labelArray[i].isUserInteractionEnabled = true
            view.addSubview(labelArray[i])
        }
        choiseLabel.frame = middleLabel.frame.offsetBy(dx: -80, dy: 0)
        choiseLabel.textAlignment = .center
        choiseLabel.text = "◉"
        choiseLabel.font = UIFont.systemFont(ofSize: 40)
        choiseLabel.textColor = .systemYellow
        view.addSubview(choiseLabel)
        view.addSubview(confirmButton)
    }
}
