
import UIKit

class ScoreScreen: UIViewController {
    private var customViewTop: UIView!
    private var customViewSide: UIView!
    private var customViewBottom: UIView!
    private var blurView: UIView!
    private var scoreLabel: UILabel!
    private var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addCustomViews()
        addBlurView()
        labelSettings()
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: []) {
            self.customViewTop.frame = PointManager.shared.updateCustomTopViewAnimation(view: self.view)
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, options: []) {
                self.customViewSide.frame = PointManager.shared.updateCustomViewSideAnimation(view: self.view)
                self.infoLabel.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 0, options: []) {
                    self.customViewBottom.frame = PointManager.shared.updateCustomViewBottomAnimation(view: self.view)
                    self.scoreLabel.alpha = 1
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
    
    private func addCustomViews() {
        customViewTop = UIView()
        customViewTop.backgroundColor = .systemGreen
        customViewTop.applyCornerRadius(radius: view.bounds.width / 2)
        view.addSubview(customViewTop)
        
        customViewSide = UIView()
        customViewSide.frame = PointManager.shared.customViewSideInitial(view: view)
        customViewSide.backgroundColor = .systemCyan
        customViewSide.applyCornerRadius(radius: view.bounds.width / 2)
        view.addSubview(customViewSide)
        
        customViewBottom = UIView()
        customViewBottom.frame = PointManager.shared.customViewBottomInitial(view: view)
        customViewBottom.backgroundColor = .systemPurple
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
    
    private func labelSettings() {
        var labelWidth: CGFloat = view.bounds.width
        var labelHeight: CGFloat = labelWidth / 4
        infoLabel = UILabel()
        scoreLabel = UILabel()
        
        scoreLabel.frame = CGRect(x: view.bounds.midX - labelWidth / 2,
                                  y: view.bounds.midY - labelHeight / 2,
                                  width: labelWidth,
                                  height: labelHeight)
        infoLabel.frame = scoreLabel.frame.offsetBy(dx: 0, dy: -100)
        infoLabel.alpha = 0
        scoreLabel.alpha = 0
        infoLabel.textAlignment = .center
        scoreLabel.textAlignment = .center
        let attributesInfo: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                             .foregroundColor: UIColor.darkGray,
                                                             .font: UIFont.systemFont(ofSize: 40,
                                                                                       weight: .light)]
        let attributesScore: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.clear,
                                                              .foregroundColor: UIColor.systemPink,
                                                              .font: UIFont.systemFont(ofSize: 70,
                                                                                       weight: .bold)]
        
        let scorePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let gameScoreFolderUrl = scorePath?.appendingPathComponent("game-score")
        let gameScoreFile = gameScoreFolderUrl?.appendingPathComponent("game-score.txt")
        let savedData = try? FileManager.default.contents(atPath: gameScoreFile!.path)
        let score = try? JSONDecoder().decode(String.self, from: savedData!)
        scoreLabel.attributedText = NSMutableAttributedString(string: score!, attributes: attributesScore)
        infoLabel.attributedText = NSMutableAttributedString(string: "YOUR BEST SCORE:", attributes: attributesInfo)
        view.addSubview(infoLabel)
        view.addSubview(scoreLabel)

    }
}
