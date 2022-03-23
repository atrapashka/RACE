
import UIKit

class GameScreen: UIViewController {
    private var markupCenter: UIView!
    private var markupCenterSecond: UIView!
    private var markupLeftSide: UIView!
    private var markupRightSide: UIView!
    private var infoView: UIView!
    private var infoLabel: UILabel!
    private var startLabel: UILabel!
    private var carItem: UIImageView!
    private var crash: UIImageView!
    private var obstacleArray: [UIImageView]!
    private var markupViewArray: [UIView]!
    private var centerPosition: CGRect!
    private var startCarLocation: CGRect!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    var carData: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        startLabelSettings()
        markupSettings()
        carItemSettings()
        infoViewSettings()
        infoLabelSettings()
        panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onCar))
        view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: []) {
            self.infoView.frame = PointManager.shared.updateInfoViewPointOne(view: self.view)
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
                self.infoView.frame = PointManager.shared.updateInfoViewPointTwo(view: self.view)
           }
        }
        
        UIView.animate(withDuration: 0.5, delay: 4, options: []) {
            self.infoLabel.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
                let raceAttributes = self.attributes(key: "raceAttributes")
                self.infoLabel.alpha = 1
                self.infoLabel.attributedText = NSAttributedString(string: "RACE▷▷▷",
                                                                          attributes: raceAttributes)
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
        
        UIView.animate(withDuration: 1, delay: 1, options: []) {
            
        } completion: { _ in
            
        }

        
        UIView.animate(withDuration: 0.8, delay: 0, options: []) {
            self.startLabel.frame = PointManager.shared.updateStartLabelPoint(view: self.view)
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, options: []) {
            self.infoView.frame = PointManager.shared.updateInfoViewPointThree(view: self.view)
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            self.markupCenter.frame = PointManager.shared.updateMarkupCenterPoint(view: self.view)
        }
        
        UIView.animate(withDuration: 1.3, delay: 0.5, options: [.repeat]) {
            self.markupCenterSecond.frame = PointManager.shared.updateMarkupCenterSecondPoint(view: self.view)
        }
        if carItem.frame.intersects(markupLeftSide.frame)
        || carItem.frame.intersects(markupRightSide.frame)
        || carItem.frame.intersects(markupCenterSecond.layer.presentation()!.frame) {
            let attributesStart: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                                  .foregroundColor: UIColor.white,
                                                                  .font: UIFont.systemFont(ofSize: 40,
                                                                                           weight: .light)]
            self.startLabel.attributedText = NSMutableAttributedString(string: "YOU LOOSE!",
                                                                  attributes: attributesStart)

            UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                self.crash.frame = CGRect(x: self.view.bounds.midX - 200, y: self.view.bounds.midX, width: 400, height: 300)
            } completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                    self.startLabel.frame = PointManager.shared.startLabelInitial(view: self.view)
                    self.startLabel.backgroundColor = .red
                } completion: { _ in
                    UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat]) {
                        self.startLabel.alpha = 0
                    }
                }
            }
            self.markupCenterSecond.frame = self.markupCenterSecond.layer.presentation()!.frame
            UIView.animate(withDuration: 0.8, delay: 0, options: []) {
                self.markupCenterSecond.frame = PointManager.shared.updateMarkupCenterSecondPoint(view: self.view)
            }
            view.removeGestureRecognizer(panGestureRecognizer)
        }
    }
    //MARK: - Private Functions
    //MARK: -
    private func markupSettings() {
        markupCenter = UIView()
        markupCenterSecond = UIView()
        markupLeftSide = UIView()
        markupRightSide = UIView()
        
        markupViewArray = [markupCenter, markupCenterSecond, markupLeftSide, markupRightSide]
        
        let elements = markupViewArray.count - 1
        for i in 0...elements {
            markupViewArray[i].backgroundColor = .white
            markupViewArray[i].frame = i == 0 ? PointManager.shared.markupCenterInitial(view: view)
            : i == 1 ? PointManager.shared.markupCenterSecondInitial(view: view)
            : i == 2 ? PointManager.shared.markupLeftInitial(view: view)
            : PointManager.shared.markupRightInitial(view: view)
            view.addSubview(markupViewArray[i])
        }
    }
    
    private func carItemSettings() {
        carItem = UIImageView()
        carItem.image = UIImage(named: carData)
        carItem.contentMode = .scaleAspectFit
        carItem.frame = PointManager.shared.carInitial(view: view)
        view.addSubview(carItem)
        
        crash = UIImageView()
        crash.image = UIImage(named: "crash")
        crash.contentMode = .scaleAspectFit
        crash.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        view.addSubview(crash)
    }
    
    private func infoViewSettings() {
        infoView = UIView()
        infoView.frame = PointManager.shared.infoViewInitial(view: view)
        infoView.applyCornerRadius(radius: 20)
        infoView.backgroundColor = .white
        view.addSubview(infoView)
    }
    
    private func infoLabelSettings() {
        let infoLabelWidth: CGFloat = 200
        let infoLabelHeight: CGFloat = 50
        let firstText = "← MOVE CAR TO →"
        infoLabel = UILabel(frame: CGRect(x: infoView.bounds.midX - infoLabelWidth / 2,
                                                 y: infoView.bounds.midY - infoLabelHeight / 2,
                                                 width: infoLabelWidth,
                                                 height: infoLabelHeight))
        infoLabel.attributedText = NSMutableAttributedString(string: firstText,
                                                                attributes: attributes(key: "mainAttributes"))
        infoLabel.textAlignment = .center
        infoView.addSubview(infoLabel)
    }
    
    private func startLabelSettings() {
        startLabel = UILabel()
        startLabel = UILabel(frame: PointManager.shared.startLabelInitial(view: view))
        startLabel.backgroundColor = .white
        startLabel.textAlignment = .center
        startLabel.attributedText = NSMutableAttributedString(string: "S    T    A    R    T",
                                                              attributes: attributes(key: "startAttributes"))
        view.addSubview(startLabel)
    }

    private func attributes(key: String) -> [NSAttributedString.Key: Any] {
        var result: [NSAttributedString.Key: Any]
        let attributesStart: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                              .foregroundColor: UIColor.systemGray,
                                                              .font: UIFont.systemFont(ofSize: 40,
                                                                                       weight: .light)]
        let attributesMain: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                         .foregroundColor: UIColor.systemGray,
                                                         .font: UIFont.systemFont(ofSize: 22,
                                                                                  weight: .light)]
        let attributesRace: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemGray,
                                                         .font: UIFont.systemFont(ofSize: 22,
                                                                                  weight: .light)]
        let attributesStartCrash: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                              .foregroundColor: UIColor.white,
                                                              .font: UIFont.systemFont(ofSize: 40,
                                                                                       weight: .light)]
        result = key == "startAttributes" ? attributesStart
        : key == "mainAttributes" ? attributesMain
        : key == "raceAttributes" ? attributesRace
        : attributesStartCrash
        
        return result
    }
}
