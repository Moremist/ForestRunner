import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    weak var startVC : StartViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: self.view.frame.size)
//            view.showsFPS = true
//            view.showsPhysics = true
//            view.showsNodeCount = true
            view.ignoresSiblingOrder = true
            scene.gameVC = self
            view.presentScene(scene)
        }
    }
    
    func initialSetUp() {

    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
