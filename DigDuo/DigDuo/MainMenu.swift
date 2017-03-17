import SpriteKit
import GameplayKit

class MainSceneScreen: SKScene {
    override init (size: CGSize) {
        super.init(size:size)
        
        //make the welcome text
        let welcome = SKLabelNode(fontNamed: "Arial")
        welcome.fontSize = 35
        welcome.verticalAlignmentMode = .top
        welcome.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.2)
        welcome.text = "Lets play" + randomEmoji(emotion: "")
        self.addChild(welcome)
        self.workWithScore(mScore: Int(arc4random_uniform(101)))
    }
    
    required init? (coder decoder:NSCoder) {
        super.init(coder: decoder)
    }
    
    override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene)
    }
    
    func randomEmoji(emotion: String?)->String{
        let emojiStart = 0x1F601
        var ascii:Int = 0
        if (emotion == "happy") {
            ascii = emojiStart + Int(arc4random_uniform(UInt32(11)))
        } else if (emotion == "sad") {
            ascii = emojiStart + Int(arc4random_uniform(UInt32(19)) + 35)
        } else {
            ascii = emojiStart + Int(arc4random_uniform(UInt32(100)))
        }
        let emoji = UnicodeScalar(ascii)?.description
        return emoji ?? "x"
    }
    
    func workWithScore(mScore: Int) {
        print("working here...")
        let url = URL(string: String(format:"http://www.numbersapi.com/%@", String(mScore)))
        makeRequest(url: url!)
    }
    
    private func makeRequest(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let html = String(data: data, encoding: String.Encoding.utf8) {
                self.splitParse(st: html)
                return
            }
        }
        task.resume()
    }
    
    private func splitParse(st:String) {
        let funFact = st
        let words = funFact.components(separatedBy: " ")
        let halfLen = words.count / 2
        let firstHalf = words[0..<halfLen].joined(separator: " ")
        let secondHalf = words[halfLen..<words.count].joined(separator: " ")
        randomParser(st1: firstHalf, st2: secondHalf)
    }
    
    private func randomParser (st1: String, st2: String){
        let parsed = SKNode()
        let a = SKLabelNode(fontNamed: "Arial")
        a.fontSize = 16
        let b = SKLabelNode(fontNamed: "Arial")
        b.fontSize = 16
        
        //let st1 = "Line 1"
        //let st2 = "Line 2"
        b.position = CGPoint(x: b.position.x, y: b.position.y - 20)
        a.text = st1
        b.text = st2
        parsed.addChild(a)
        parsed.addChild(b)
        parsed.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.5)
        self.addChild(parsed)
    }
}
