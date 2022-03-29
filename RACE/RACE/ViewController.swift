
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var blurViewSecond: UIView!
    @IBOutlet weak var blurViewThird: UIView!
    @IBOutlet weak var blurViewFourth: UIView!
    private var menuView: UIView!
    @IBOutlet weak var mainBlurView: UIImageView!
    private var simpleCar: UIButton!
    private var miniCar: UIButton!
    private var sportCar: UIButton!
    private var blackCar: UIButton!
    private var buttonBurger: UIButton!
    private var carArray: [UIButton]!
    var carModel: String = "car0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        buttonBurger = UIButton()
        buttonBurger.addTarget(self, action: #selector(onBurger), for: .touchUpInside)
        buttonBurger.setImage(UIImage(named: "burgerButton"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBurger)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                                   action: #selector(onSwipeRight))
        swipeRightGestureRecognizer.direction = .right
        
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                                  action: #selector(onSwipeLeft))
        swipeLeftGestureRecognizer.direction = .left
        
        addBlurView()
        menuViewSettings()
        view.addGestureRecognizer(swipeRightGestureRecognizer)
        view.addGestureRecognizer(swipeLeftGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        blurElementsSettings()
    }
    
    @IBAction func onBurnoutButon(_ sender: Any) {
        transitToGameScreen()
    }
    
    @objc private func onSwipeRight() {
        if menuView.frame == PointManager.shared.sideMenuInitial(view: view) {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = PointManager.shared.updateSideMenuAnimationPoint(view: self.view)
            }
        } else {
            menuView.frame = PointManager.shared.updateSideMenuAnimationPoint(view: self.view)
        }
    }
    
    @objc private func onSwipeLeft() {
        if menuView.frame == PointManager.shared.updateSideMenuAnimationPoint(view: view) {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = PointManager.shared.sideMenuInitial(view: self.view)
            }
        } else {
            menuView.frame = PointManager.shared.sideMenuInitial(view: self.view)
        }
    }
    
    @objc private func onBurger() {
        if menuView.frame == PointManager.shared.sideMenuInitial(view: view) {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = PointManager.shared.updateSideMenuAnimationPoint(view: self.view)
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = PointManager.shared.sideMenuInitial(view: self.view)
            }
        }
    }
    
    @objc private func onSimpleCar() {
        addAlert(model: "car0", title: "Red Muscle Car", message: "40 l/10km - it's not the limit")
    }
    
    @objc private func onSportCar() {
        addAlert(model: "car1", title: "Simple Car", message: "Take your drive license a few days ago? Get this")
    }
    
    @objc private func onMiniCar() {
        addAlert(model: "car2", title: "Sleeper", message: "You think your'e fast? I don't think so...")
    }
    
    @objc private func onBlackCar() {
        addAlert(model: "car3", title: "Sport Car", message: "Hold your breath and get ready for insanity...")
    }
    
    private func menuViewSettings() {
        menuView = UIView()
        menuView.frame = PointManager.shared.sideMenuInitial(view: view)
        view.addSubview(menuView)
        
        buttonsOnMenuViewSettings()
    }
    
    private func buttonsOnMenuViewSettings() {
        simpleCar = UIButton()
        sportCar = UIButton()
        miniCar = UIButton()
        blackCar = UIButton()
        carArray = [simpleCar, sportCar, miniCar, blackCar]
        let carWidth: CGFloat = 70
        let carHeight: CGFloat = 130

        let simpleCarFrame = CGRect(x: menuView.bounds.midX - carWidth / 2,
                                    y: menuView.bounds.minY + carHeight,
                                    width: carWidth,
                                    height: carHeight)
        
        func offset(button: UIButton) -> CGRect {
            let carOffset: CGRect = button.frame.offsetBy(dx: 0, dy: carHeight * 1.2)
            return carOffset
        }
        
        let elements = carArray.count - 1
        for i in 0...elements {
            carArray[i].setImage(UIImage(named: "car\(i)"), for: .normal)
            carArray[i].frame = i == 0 ? simpleCarFrame
            : i == 1 ? offset(button: simpleCar)
            : i == 2 ? offset(button: sportCar)
            : offset(button: miniCar)
            menuView.addSubview(carArray[i])
        }
        
        simpleCar.addTarget(self, action: #selector(onSimpleCar), for: .touchUpInside)
        sportCar.addTarget(self, action: #selector(onSportCar), for: .touchUpInside)
        miniCar.addTarget(self, action: #selector(onMiniCar), for: .touchUpInside)
        blackCar.addTarget(self, action: #selector(onBlackCar), for: .touchUpInside)
    }
    
    private func blurElementsSettings() {
        cornerRadius()
        
        blurView.frame = PointManager.shared.blurViewInitial(view: view)
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurView.frame = PointManager.shared.updateBlurViewAnimationPoint(view: self.view)
        }
        
        blurViewSecond.frame = PointManager.shared.blurViewSecondInitial(view: view)
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewSecond.frame = PointManager.shared.updateBlurViewSecondAnimationPoint(view: self.view)
        }
        
        blurViewThird.frame = PointManager.shared.blurViewThirdInitial(view: view)
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewThird.frame = PointManager.shared.updateBlurViewThirdAnimationPoint(view: self.view)
        }
        
        blurViewFourth.frame = PointManager.shared.blurViewFourthInitial(view: view)
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat]) {
            self.blurViewFourth.frame = PointManager.shared.updateBlurViewFourthAnimationPoint(view: self.view)
        }
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
    
    private func addAlert(model: String, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.carModel = "car0"
        }
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            self.carModel = model
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func transitToGameScreen() {
        let storyboard = UIStoryboard.init(name: "GameScreen", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController() as! GameScreen
        navigationController?.pushViewController(vc, animated: true)

        vc.carData = carModel
    }
}

