import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let skView = self.view as! SKView?
        if skView?.scene == nil {
            skView?.showsFPS = true
            skView?.showsNodeCount = true
            //GameScene.setScale(.asp)
            let game_Scene = MainSceneScreen(size: (skView?.bounds.size)!)
            game_Scene.scaleMode = .aspectFill
            skView?.presentScene(game_Scene)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
