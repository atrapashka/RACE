
import Foundation
import UIKit

class PointManager {
    static let shared = PointManager()
    
    let blurWidth: CGFloat = 500
    let blurHeight: CGFloat = 500
    let markupWidth: CGFloat = 10
    let markupHeight: CGFloat = 500
    let carWidth: CGFloat = 70
    let carHeight: CGFloat = 130
    let infoViewWidth: CGFloat = 250
    let infoViewHeight: CGFloat = 40
    let startLabelWidth: CGFloat = 400
    let startLabelHeight: CGFloat = 45
    let obstacleWidth: CGFloat = 100
    let obstacleHeight: CGFloat = 120
    let buttonWidth: CGFloat = 300
    let buttonHeight: CGFloat = 75
    let menuWidth: CGFloat = 350
    let menuHeight: CGFloat = 200
    let confirmButtonWidth: CGFloat = 30
    let confirmButtonHeight: CGFloat = 30
    let labelWidth: CGFloat = 150
    let labelHeight: CGFloat = 60
    
    func updatePointStartScreen(view: UIView, position: pointsStartScreen) -> CGRect {
        switch position {
        case pointsStartScreen.blurViewInitialPoint:
            return blurViewInitial(view: view)
        case pointsStartScreen.blurViewAnimationPoint:
            return updateBlurViewAnimationPoint(view: view)
        case pointsStartScreen.blurViewSecondInitialPoint:
            return blurViewSecondInitial(view: view)
        case pointsStartScreen.blurViewSecondAnimationPoint:
            return updateBlurViewSecondAnimationPoint(view: view)
        case pointsStartScreen.blurViewThirdInitialPoint:
            return blurViewThirdInitial(view: view)
        case pointsStartScreen.blurViewThirdAnimationPoint:
            return updateBlurViewThirdAnimationPoint(view: view)
        case pointsStartScreen.blurViewFourthInitialPoint:
            return blurViewFourthInitial(view: view)
        case pointsStartScreen.blurViewFourthAnimationPoint:
            return updateBlurViewFourthAnimationPoint(view: view)
        case pointsStartScreen.sideMenuInitialPoint:
            return sideMenuInitial(view: view)
        case pointsStartScreen.sideMenuAnimationPoint:
            return updateSideMenuAnimationPoint(view: view)
        }
    }
    
    func updatePointGameScreen(view: UIView, position: pointsGameScreen) -> CGRect {
        switch position {
        case pointsGameScreen.markupCenterInitialPoint:
            return markupCenterInitial(view: view)
        case pointsGameScreen.markupCenterSecondInitialPoint:
            return markupCenterSecondInitial(view: view)
        case pointsGameScreen.markupLeftInitialPoint:
            return markupLeftInitial(view: view)
        case pointsGameScreen.markupRightInitialPoint:
            return markupRightInitial(view: view)
        case pointsGameScreen.infoViewInitialPoint:
            return infoViewInitial(view: view)
        case pointsGameScreen.startLabelInitialPoint:
            return startLabelInitial(view: view)
        case pointsGameScreen.infoViewAnimationPointOne:
            return updateInfoViewPointOne(view: view)
        case pointsGameScreen.infoViewAnimationPointTwo:
            return updateInfoViewPointTwo(view: view)
        case pointsGameScreen.infoViewAnimationPointThree:
            return updateInfoViewPointThree(view: view)
        case pointsGameScreen.startLabelAnimationPoint:
            return updateStartLabelPoint(view: view)
        case pointsGameScreen.markupCenterAnimationPoint:
            return updateMarkupCenterPoint(view: view)
        case pointsGameScreen.markupCenterSecondAnimationPoint:
            return updateMarkupCenterSecondPoint(view: view)
        case pointsGameScreen.startLabelAnimationCrashPoint:
            return updateStartLabelCrashAnimationPoint(view: view)
        }
    }
    
    func updatePointObstacle(view: UIView, position: pointsObstacles) -> CGRect {
        switch position {
        case pointsObstacles.leftObstacleViewInitialPoint:
            return leftObstacleViewInitial(view: view)
        case pointsObstacles.centerObstacleViewInitialPoint:
            return centerObstacleViewInitial(view: view)
        case pointsObstacles.rightObstacleViewInitialPoint:
            return rightObstacleViewInitial(view: view)
        case pointsObstacles.leftObstacleViewAnimationPoint:
            return updateLeftObstacleViewAnimationPoint(view: view)
        case pointsObstacles.centerObstacleViewAnimationPoint:
            return updateCenterObstacleViewAnimationPoint(view: view)
        case pointsObstacles.rightObstacleViewAnimationPoint:
            return updateRightObstacleViewAnimationPoint(view: view)
        case pointsObstacles.leftObstacleViewRandomPoint:
            return updateLeftObstacleViewRandomPoint(view: view)
        case pointsObstacles.centerObstacleViewRandomPoint:
            return updateCenterObstacleViewRandomPoint(view: view)
        case pointsObstacles.rightObsctacleViewRandomPoint:
            return updateRightObstacleViewRandomPoint(view: view)
        }
    }
    
    func updatePointSettingsScreen(view: UIView, position: pointsSettingsScreen) -> CGRect {
        switch position {
        case .customViewTopAnimationPoint:
            return updateCustomTopViewAnimation(view: view)
        case .customViewSideInitialPoint:
            return customViewSideInitial(view: view)
        case .customViewSideAnimationPoint:
            return updateCustomViewSideAnimation(view: view)
        case .customViewBottomInitialPoint:
            return customViewBottomInitial(view: view)
        case .customViewBottomAnimationPoint:
            return updateCustomViewBottomAnimation(view: view)
        case .backgroundButtonPoint:
            return backgroundButtonInitial(view: view)
        case .obstacleButtonPoint:
            return obstacleButtonInitial(view: view)
        case .difficultyButtonPoint:
            return difficultyButtonInitial(view: view)
        case .backgroundViewAnimationPoint:
            return backgroundViewAnimation(view: view)
        case .obstacleViewAnimationPoint:
            return obstacleViewAnimation(view: view)
        case .difficultyViewAnimationPoint:
            return difficultyViewAnimation(view: view)
        case .buttonInitialPoint:
            return updateButtonInitial(view: view)
        case .middleLabelInitialPoint:
            return middleLabelInitial(view: view)
        case .confirmButtonInitialPoint:
            return confirmButtonInitial(view: view)
        case .backgroundViewInitialPoint:
            return backgroundViewInitial(view: view)
        case .obsatcleViewInitialPoint:
            return obstacleViewInitial(view: view)
        case .difficultyViewInitialPoint:
            return difficultyViewInitial(view: view)
        }
    }
    
    //MARK: - Functions for StartScreen
    //MARK: -
  
    func blurViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - blurWidth,
                      y: view.bounds.midY - blurHeight * 1.5,
                      width: blurWidth,
                      height: blurHeight)
    }
    
    func updateBlurViewAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX + blurWidth / 4,
                      y: view.bounds.midY - blurHeight * 1.5,
                      width: blurWidth,
                      height: blurHeight)
    }
    
    func blurViewSecondInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX + blurWidth / 4,
                      y: view.bounds.midY - blurHeight,
                      width: blurWidth,
                      height: blurHeight)
    }
    
    func updateBlurViewSecondAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - blurWidth,
                      y: view.bounds.midY - blurHeight,
                      width: blurWidth,
                      height: blurHeight)
    }
    
    func blurViewThirdInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - blurWidth,
                      y: view.bounds.midY - blurHeight / 2,
                       width: blurWidth,
                       height: blurHeight)
    }
    
    func updateBlurViewThirdAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX + blurWidth / 4,
                      y: view.bounds.midY - blurHeight / 2,
                       width: blurWidth,
                       height: blurHeight)
    }
    
    func blurViewFourthInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX + blurWidth / 4,
                      y: view.bounds.midY,
                      width: blurWidth,
                      height: blurHeight)
    }
    
    func updateBlurViewFourthAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - blurWidth,
                      y: view.bounds.midY,
                      width: blurWidth,
                      height: blurHeight)
    }
    
    func sideMenuInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minY - view.bounds.width / 4.5,
                      y: view.bounds.minX,
                      width: view.bounds.width / 4.5,
                      height: view.bounds.height)
    }
    
    func updateSideMenuAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minY,
                      y: view.bounds.minX,
                      width: view.bounds.width / 4.5,
                      height: view.bounds.height)
    }

    //MARK: - Functions for GameScreen
    //MARK: -
    
    func markupCenterInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.midY - markupHeight / 1.5,
                      width: markupWidth,
                      height: markupHeight)
    }
    
    func markupCenterSecondInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.minY - markupHeight * 2.5,
                      width: markupWidth,
                      height: markupHeight * 2)
    }
    
    func markupLeftInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minX + markupWidth / 2,
                      y: view.bounds.minY,
                      width: markupWidth,
                      height: view.bounds.height)
    }
    
    func markupRightInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX - markupWidth * 1.5,
                      y: view.bounds.minY,
                      width: markupWidth,
                      height: view.bounds.height)
    }
    
    func carInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - carWidth / 2,
                      y: view.bounds.maxY - carHeight * 1.5,
                      width: carWidth,
                      height: carHeight)
    }
    
    func infoViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2,
                      y: view.bounds.midY - infoViewHeight,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func startLabelInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - startLabelWidth / 2,
                      y: view.bounds.midY + startLabelHeight * 4,
                      width: startLabelWidth,
                      height: startLabelHeight)
    }
    
    func updateInfoViewPointOne(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2 - 20,
                      y: view.bounds.midY - infoViewHeight,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func updateInfoViewPointTwo(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2 + 20,
                      y: view.bounds.midY - infoViewHeight,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func updateInfoViewPointThree(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - infoViewWidth / 2,
                      y: view.bounds.midY + infoViewHeight * 25,
                      width: infoViewWidth,
                      height: infoViewHeight)
    }
    
    func updateStartLabelPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - startLabelWidth / 2,
                      y: view.bounds.midY + startLabelHeight * 22,
                      width: startLabelWidth,
                      height: startLabelHeight)
    }
    
    func updateMarkupCenterPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.maxY + markupHeight * 0.6,
                      width: markupWidth,
                      height: markupHeight)
    }
    
    func updateMarkupCenterSecondPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - markupWidth / 2,
                      y: view.bounds.maxY + markupHeight * 1.6,
                      width: markupWidth,
                      height: markupHeight * 2)
    }
    
    func updateStartLabelCrashAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - startLabelWidth / 2,
                      y: view.bounds.minY + startLabelHeight * 3,
                      width: startLabelWidth,
                      height: startLabelHeight)
    }
    
    //MARK: - Functions for GameScreen/ObstaclesArray
    //MARK: -
    
    func leftObstacleViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minX,
                      y: view.bounds.minY - obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }
    
    func centerObstacleViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - obstacleWidth / 2,
                      y: view.bounds.minY - obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }
    
    func rightObstacleViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX - obstacleWidth,
                      y: view.bounds.minY - obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }
    
    func updateLeftObstacleViewAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minX,
                      y: view.bounds.maxY + obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }
    
    func updateCenterObstacleViewAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - obstacleWidth / 2,
                      y: view.bounds.maxY + obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }

    func updateRightObstacleViewAnimationPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX - obstacleWidth,
                      y: view.bounds.maxY + obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }

    func updateLeftObstacleViewRandomPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minX + CGFloat.random(in: 20...100),
                      y: view.bounds.minY - obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }

    func updateCenterObstacleViewRandomPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - obstacleWidth / (Double.random(in: 0.5...2.5)),
                      y: view.bounds.minY - obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }

    func updateRightObstacleViewRandomPoint(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX - obstacleWidth * (Double.random(in: 1...2.5)),
                      y: view.bounds.minY - obstacleHeight * 2,
                      width: obstacleWidth,
                      height: obstacleHeight)
    }
    
    //MARK: - Functions for SettingsScreen
    //MARK: -
    
    func updateCustomTopViewAnimation(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.minX - view.bounds.width / 2,
                      y: view.bounds.minY - view.bounds.height / 4,
                      width: view.bounds.width,
                      height: view.bounds.width)
    }
    
    func customViewSideInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX + view.bounds.width / 2,
                      y: view.bounds.midY - view.bounds.height / 4,
                      width: view.bounds.width,
                      height: view.bounds.width)
    }
    
    func updateCustomViewSideAnimation(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX + view.bounds.width / 4,
                      y: view.bounds.midY - view.bounds.height / 4,
                      width: view.bounds.width,
                      height: view.bounds.width)
    }
    
    func customViewBottomInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - view.bounds.width,
                      y: view.bounds.maxY + view.bounds.height / 2,
                      width: view.bounds.width * 2,
                      height: view.bounds.width)
    }
    
    func updateCustomViewBottomAnimation(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - view.bounds.width,
                      y: view.bounds.maxY - view.bounds.height / 6,
                      width: view.bounds.width * 2,
                      height: view.bounds.width)
    }
    
    func backgroundButtonInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - buttonWidth / 2,
                      y: view.bounds.midY - buttonHeight * 4,
                      width: buttonWidth,
                      height: buttonHeight)
    }
    
    func obstacleButtonInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - buttonWidth / 2,
                      y: view.bounds.midY - buttonHeight / 2,
                      width: buttonWidth,
                      height: buttonHeight)
    }
    
    func difficultyButtonInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - buttonWidth / 2,
                      y: view.bounds.midY + buttonHeight * 3,
                      width: buttonWidth,
                      height: buttonHeight)
    }
    
    func backgroundViewAnimation(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - menuWidth / 2,
                      y: view.bounds.midY - menuWidth,
                      width: menuWidth,
                      height: menuHeight)
    }
    
    func obstacleViewAnimation(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - menuWidth / 2,
                      y: view.bounds.midY - menuHeight / 2,
                      width: menuWidth,
                      height: menuHeight)
    }
    
    func difficultyViewAnimation(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - menuWidth / 2,
                      y: view.bounds.midY + menuWidth / 2.3,
                      width: menuWidth,
                      height: menuHeight)
    }
    
    func updateButtonInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX,
                      y: view.bounds.midY,
                      width: 0,
                      height: 0)
    }
    
    func middleLabelInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.midX - labelWidth / 2,
                      y: view.bounds.midY - labelHeight / 2,
                      width: labelWidth,
                      height: labelHeight)
    }
    
    func confirmButtonInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX - confirmButtonWidth * 1.9,
                      y: view.bounds.maxY - confirmButtonHeight * 1.7,
                      width: confirmButtonWidth * 1.3,
                      height: confirmButtonHeight * 1.3)
    }
    
    func backgroundViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX + menuWidth / 2,
                      y: view.bounds.midY - menuWidth,
                      width: menuWidth,
                      height: menuHeight)
    }
    
    func obstacleViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX + menuWidth / 2,
                      y: view.bounds.midY - menuHeight / 2,
                      width: menuWidth,
                      height: menuHeight)
    }
    
    func difficultyViewInitial(view: UIView) -> CGRect {
        return CGRect(x: view.bounds.maxX + menuWidth / 2,
                      y: view.bounds.midY + menuWidth / 2.3,
                      width: menuWidth,
                      height: menuHeight)
    }

}
