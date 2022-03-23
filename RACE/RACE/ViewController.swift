
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
    var carModel: String = "car1"
    
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
        if menuView.frame == locations(position: "menu") {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = self.locations(position: "menuOpen")
            }
        } else {
            menuView.frame = locations(position: "menuOpen")
        }
    }
    
    @objc private func onSwipeLeft() {
        if menuView.frame == locations(position: "menuOpen") {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = self.locations(position: "menu")
            }
        } else {
            menuView.frame = locations(position: "menu")
        }
    }
    
    @objc private func onBurger() {
        if menuView.frame == locations(position: "menu") {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = self.locations(position: "menuOpen")
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.menuView.frame = self.locations(position: "menu")
            }
        }
    }
    
    @objc private func onSimpleCar() {
        carModel = "car1"
    }
    
    @objc private func onSportCar() {
        carModel = "car4"
    }
    
    @objc private func onMiniCar() {
        carModel = "car2"
    }
    
    @objc private func onBlackCar() {
        carModel = "car3"
    }
    
    private func menuViewSettings() {
        menuView = UIView()
        menuView.frame = locations(position: "menu")
        view.addSubview(menuView)
        
        buttonsOnMenuViewSettings()
    }
    
    private func buttonsOnMenuViewSettings() {
        let carWidth: CGFloat = 70
        let carHeight: CGFloat = 130
        
        simpleCar = UIButton()
        sportCar = UIButton()
        miniCar = UIButton()
        blackCar = UIButton()
        
//        carArray = [simpleCar, miniCar, blackCar, sportCar]
//        
//        let elements = carArray.count - 1
//        for i in 0...elements {
//            carArray[i].setImage(UIImage(named: "car\(i)"), for: .normal)
//            carArray[i].frame = i == 0 ?
//        }
        
        simpleCar.addTarget(self, action: #selector(onSimpleCar), for: .touchUpInside)
        simpleCar.setImage(UIImage(named: "car1"), for: .normal)
        simpleCar.frame = CGRect(x: menuView.bounds.midX - carWidth / 2,
                                 y: menuView.bounds.minY + carHeight,
                                 width: carWidth,
                                 height: carHeight)
        
        sportCar.addTarget(self, action: #selector(onSportCar), for: .touchUpInside)
        sportCar.setImage(UIImage(named: "car4"), for: .normal)
        sportCar.frame = simpleCar.frame.offsetBy(dx: 0, dy: carHeight * 1.2)
        
        miniCar.addTarget(self, action: #selector(onMiniCar), for: .touchUpInside)
        miniCar.setImage(UIImage(named: "car2"), for: .normal)
        miniCar.frame = sportCar.frame.offsetBy(dx: 0, dy: carHeight * 1.2)
        
        blackCar.addTarget(self, action: #selector(onBlackCar), for: .touchUpInside)
        blackCar.setImage(UIImage(named: "car3"), for: .normal)
        blackCar.frame = miniCar.frame.offsetBy(dx: 0, dy: carHeight * 1.2)
        menuView.addSubview(simpleCar)
        menuView.addSubview(miniCar)
        menuView.addSubview(blackCar)
        menuView.addSubview(sportCar)
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
        let menuWidth: CGFloat = view.bounds.width / 4.5
        let menuHeight: CGFloat = view.bounds.height
        
        
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
        let menu = CGRect(x: view.bounds.minY - menuWidth,
                          y: view.bounds.minX,
                          width: menuWidth,
                          height: menuHeight)
        let menuOpen = CGRect(x: view.bounds.minY,
                              y: view.bounds.minX,
                              width: menuWidth,
                              height: menuHeight)
        
        result = position == "blur" ? blurViewLocation
        : position == "blurAnimation" ? blurViewAnimation
        : position == "blurSecond" ? blurViewSecondLocation
        : position == "blurSecondAnimation" ? blurViewSecondAnimation
        : position == "blurThird" ? blurViewThirdLocation
        : position == "blurThirdAnimation" ? blurViewThirdAnimation
        : position == "blurFourth" ? blurViewFourthLocation
        : position == "blurFourthAnimation" ? blurViewFourthAnimation
        : position == "menu" ? menu
        : menuOpen
        
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

        vc.carData = carModel
    }
}

