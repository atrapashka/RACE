
import UIKit

class GameScreen: UIViewController {
    private var markupCenter: UIView!
    private var markupCenterSecond: UIView!
    private var markupLeftSide: UIView!
    private var markupRightSide: UIView!
    private var infoView: UIView!
    private var markupViewArray: [UIView]!
    private var infoLabel: UILabel!
    private var startLabel: UILabel!
    private var scoreLabel: UILabel!
    private var carItem: UIImageView!
    private var crash: UIImageView!
    private var leftObstacleView: UIImageView!
    private var centerObstacleView: UIImageView!
    private var rightObstacleView: UIImageView!
    private var obstacleViewArray: [UIImageView]!
    private var obstacleArrayDefault: [UIImage]!
    private var centerPosition: CGRect!
    private var startCarLocation: CGRect!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var timer: Timer!
    private var difficultyControl: Double!
    private var score: Int = 0
    var carData: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "BackSet") == nil {
            UserDefaults.standard.set("ROAD", forKey: "BackSet")
        } else if UserDefaults.standard.value(forKey: "ObstSet") == nil {
            UserDefaults.standard.set("DEFAULT", forKey: "ObstSet")
        } else if UserDefaults.standard.value(forKey: "DiffSet") == nil {
            UserDefaults.standard.set("NORMAL", forKey: "DiffSet")
        }
        
        let defaultBackground = UserDefaults.standard.value(forKey: "BackSet")
        if defaultBackground as! String == "ROAD" {
            view.backgroundColor = .systemGray
        } else {
            let imageView = UIImageView()
            imageView.image = UIImage(named: defaultBackground as! String)
            imageView.frame = view.bounds
            view.addSubview(imageView)
        }
        
        if UserDefaults.standard.value(forKey: "DiffSet") as! String == "NORMAL" {
            difficultyControl = 1
        } else if UserDefaults.standard.value(forKey: "DiffSet") as! String == "EASY" {
            difficultyControl = 1.5
        } else if UserDefaults.standard.value(forKey: "DiffSet") as! String == "HARD" {
            difficultyControl = 0.5
        }
        
        let scorePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let gameScoreFolderUrl = scorePath?.appendingPathComponent("game-score")
        try? FileManager.default.createDirectory(at: gameScoreFolderUrl!, withIntermediateDirectories: true)
        let gameScoreFile = gameScoreFolderUrl?.appendingPathComponent("game-score.txt")
        let scoreText = "0"
        let scoreData = try? JSONEncoder().encode(scoreText)
        if FileManager.default.fileExists(atPath: gameScoreFile!.path) == true {

        } else {
            FileManager.default.createFile(atPath: gameScoreFile!.path,
                                           contents: scoreData,
                                           attributes: nil)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(fireTimer),
                                         userInfo: nil,
                                         repeats: true)
        
        startLabelSettings()
        markupSettings()
        carItemSettings()
        obstaclesSettings()
        infoViewSettings()
        infoLabelSettings()
        scoreLabelSettings()
        panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onCar))
        view.addGestureRecognizer(panGestureRecognizer)
        tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
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
    
    @objc func fireTimer() {
        if leftObstacleView.layer.presentation()!.frame.maxY > view.bounds.midY * 2.5  {
            leftObstacleView.image = obstacleArrayDefault[Int.random(in: 0...obstacleArrayDefault.count - 1)]
            leftObstacleView.frame = PointManager.shared.updateLeftObstacleViewRandomPoint(view: view)
        }
        
        if centerObstacleView.layer.presentation()!.frame.maxY > view.bounds.midY * 2.5  {
            centerObstacleView.image = obstacleArrayDefault[Int.random(in: 0...obstacleArrayDefault.count - 1)]
            centerObstacleView.frame = PointManager.shared.updateCenterObstacleViewRandomPoint(view: view)
        }
        
        if rightObstacleView.layer.presentation()!.frame.maxY > view.bounds.midY * 2.5  {
            rightObstacleView.image = obstacleArrayDefault[Int.random(in: 0...obstacleArrayDefault.count - 1)]
            rightObstacleView.frame = PointManager.shared.updateRightObstacleViewRandomPoint(view: view)
        }
        
        if carItem.frame != PointManager.shared.carInitial(view: view) {
            score += 10
            scoreLabel.attributedText = NSMutableAttributedString(string: String(score),
                                                                  attributes: attributes(key: "scoreAttributes"))
        }
    }

    @objc func onCar(gesture: UIPanGestureRecognizer) {
        let width: CGFloat = 70
        let height: CGFloat = 130
        let location = gesture.location(in: view)
        let x = location.x
        let y = location.y
        carItem.frame = CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height)
        
        UIView.animate(withDuration: 5 * difficultyControl, delay: 3, options: [.repeat]) {
            self.leftObstacleView.frame = PointManager.shared.updateLeftObstacleViewAnimationPoint(view: self.view)
        }
        
        UIView.animate(withDuration: 5 * difficultyControl, delay: 5, options: [.repeat]) {
            self.centerObstacleView.frame = PointManager.shared.updateCenterObstacleViewAnimationPoint(view: self.view)
        }
        
        UIView.animate(withDuration: 5 * difficultyControl, delay: 1, options: [.repeat]) {
            self.rightObstacleView.frame = PointManager.shared.updateRightObstacleViewAnimationPoint(view: self.view)
        }

        UIView.animate(withDuration: 0.8, delay: 0, options: []) {
            self.startLabel.frame = PointManager.shared.updateStartLabelPoint(view: self.view)
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, options: []) {
            self.infoView.frame = PointManager.shared.updateInfoViewPointThree(view: self.view)
        }
        
        UIView.animate(withDuration: 1 * difficultyControl, delay: 0, options: []) {
            self.markupCenter.frame = PointManager.shared.updateMarkupCenterPoint(view: self.view)
        }
        
        UIView.animate(withDuration: 1.3 * difficultyControl, delay: 0.5, options: [.repeat]) {
            self.markupCenterSecond.frame = PointManager.shared.updateMarkupCenterSecondPoint(view: self.view)
        }
        if carItem.frame.intersects(markupLeftSide.frame)
            || carItem.frame.intersects(markupRightSide.frame)
            || carItem.frame.intersects(leftObstacleView.layer.presentation()!.frame)
            || carItem.frame.intersects(centerObstacleView.layer.presentation()!.frame)
            || carItem.frame.intersects(rightObstacleView.layer.presentation()!.frame) {
            let attributesStart: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                                  .foregroundColor: UIColor.white,
                                                                  .font: UIFont(name: "BebasNeue-Regular",             size: 40)]
            self.startLabel.attributedText = NSMutableAttributedString(string: "Y O U   L O O S E !",
                                                                  attributes: attributesStart)

            UIView.animate(withDuration: 0.2, delay: 0, options: []) {
                self.crash.frame = CGRect(x: self.view.bounds.midX - 200, y: self.view.bounds.midX, width: 400, height: 300)
                self.carItem.image = UIImage(named: "crashCar")
                self.carItem.frame = CGRect(x: x - width / 2, y: y - height / 2, width: 200, height: 200)
            } completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0, options: []) {
                    self.startLabel.frame = PointManager.shared.updateStartLabelCrashAnimationPoint(view: self.view)
                    self.startLabel.backgroundColor = .red
                    self.leftObstacleView.alpha = 0
                    self.centerObstacleView.alpha = 0
                    self.rightObstacleView.alpha = 0
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
            timer.invalidate()
            view.removeGestureRecognizer(panGestureRecognizer)
            view.addGestureRecognizer(tapGestureRecognizer)
            let endScore = scoreLabel.text
            let scoreData = try? JSONEncoder().encode(endScore)
            let scorePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let gameScoreFolderUrl = scorePath?.appendingPathComponent("game-score")
            let gameScoreFile = gameScoreFolderUrl?.appendingPathComponent("game-score.txt")
            let gameScoreCurrentFile = gameScoreFolderUrl?.appendingPathComponent("game-score-current.txt")
            FileManager.default.createFile(atPath: gameScoreCurrentFile!.path,
                                           contents: scoreData,
                                           attributes: nil)
            let savedBestScore = try? FileManager.default.contents(atPath: gameScoreFile!.path)
            let currentScore = try? FileManager.default.contents(atPath: gameScoreCurrentFile!.path)
            let scoreBest = try? JSONDecoder().decode(String.self, from: savedBestScore!)
            let scoreCurrent = try? JSONDecoder().decode(String.self, from: currentScore!)
            if  Int(scoreBest!)! < Int(scoreCurrent!)! {
                try? scoreData!.write(to: gameScoreFile!)
            }
        }
    }
    
    @objc func onTap(gesture: UITapGestureRecognizer) {
        navigationController?.popToRootViewController(animated: true)
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
        carItem.applyShadow(visibility: true)
        view.addSubview(carItem)
        
        crash = UIImageView()
        crash.image = UIImage(named: "crash")
        crash.contentMode = .scaleAspectFit
        crash.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        view.addSubview(crash)
    }
    
    private func obstaclesSettings() {
        leftObstacleView = UIImageView()
        centerObstacleView = UIImageView()
        rightObstacleView = UIImageView()
        
        
        obstacleViewArray = [leftObstacleView, centerObstacleView, rightObstacleView]
        
        if UserDefaults.standard.value(forKey: "ObstSet") as? String == "DEFAULT" {
            obstacleArrayDefault = [UIImage(named: "bio")!,
                                    UIImage(named: "tnt")!,
                                    UIImage(named: "car2")!,
                                    UIImage(named: "rock")!,
                                    UIImage(named: "car1")!,
                                    UIImage(named: "car3")!]
        } else if UserDefaults.standard.value(forKey: "ObstSet") as? String == "PEPPA" {
            obstacleArrayDefault = [UIImage(named: "peppa")!,
                                    UIImage(named: "peppa")!,
                                    UIImage(named: "peppa")!,
                                    UIImage(named: "peppa")!,
                                    UIImage(named: "peppa")!,
                                    UIImage(named: "peppa")!]
        } else if UserDefaults.standard.value(forKey: "ObstSet") as? String == "MUSK" {
            obstacleArrayDefault = [UIImage(named: "musk")!,
                                    UIImage(named: "musk")!,
                                    UIImage(named: "musk")!,
                                    UIImage(named: "musk")!,
                                    UIImage(named: "musk")!,
                                    UIImage(named: "musk")!]
        }
        
        leftObstacleView.image = obstacleArrayDefault[Int.random(in: 0...obstacleArrayDefault.count - 1)]
        centerObstacleView.image = obstacleArrayDefault[Int.random(in: 0...obstacleArrayDefault.count - 1)]
        rightObstacleView.image = obstacleArrayDefault[Int.random(in: 0...obstacleArrayDefault.count - 1)]
        
        for i in 0...obstacleViewArray.count - 1 {
            obstacleViewArray[i].frame = i == 0 ? PointManager.shared.leftObstacleViewInitial(view: view)
            : i == 1 ? PointManager.shared.centerObstacleViewInitial(view: view)
            : PointManager.shared.rightObstacleViewInitial(view: view)
            obstacleViewArray[i].contentMode = .scaleAspectFit
            obstacleViewArray[i].applyShadow(visibility: true)
            view.addSubview(obstacleViewArray[i])
        }
    }
    
    private func scoreLabelSettings() {
        scoreLabel = UILabel()
        scoreLabel.frame = view.bounds.offsetBy(dx: -150, dy: 400)
        scoreLabel.textAlignment = .center
        scoreLabel.attributedText = NSMutableAttributedString(string: "0",
                                                              attributes: attributes(key: "scoreAttributes"))
        view.addSubview(scoreLabel)
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
        let attributesScore: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                              .foregroundColor: UIColor.white,
                                                              .font: UIFont(name: "BebasNeue-Regular",
                                                                            size: 40)]
        result = key == "startAttributes" ? attributesStart
        : key == "mainAttributes" ? attributesMain
        : key == "raceAttributes" ? attributesRace
        : key == "scoreAttributes" ? attributesScore
        : attributesStartCrash
        
        return result
    }
}
