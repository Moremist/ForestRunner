import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    weak var gameVC : GameViewController?
    
    var heroInAir = false
    var gameIsPaused = false {
        didSet {
            endGame()
        }
    }
    
    var jumpCount = 0
    
    var timer = Timer()

    var heroNodeTexture = SKTexture(imageNamed: "Warrior_Run_1")
    var heroSpriteNode = SKSpriteNode()
    var heroNode = SKNode()
    
    var backGroundNodeArray = [SKNode]()
    var enemyNodeArray = [SKNode]()
    
    var groundSpriteNode = SKSpriteNode()
    var groundNode = SKNode()
    
    var wallSpriteNode = SKSpriteNode()
    var wallNode = SKNode()
    
    var secondWallSpriteNode = SKSpriteNode()
    var secondWallNode = SKNode()
        
    let textures = Textures()
    
    var musicNode = SKAudioNode()
    
    var heroMask : UInt32 = 1
    var groundMask : UInt32 = 2
    var wallMask : UInt32 = 3
    var enemyMask : UInt32 = 4
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        initialSetUp()
    }
    
    func initialSetUp() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: -3, dy: -10)
        
        addBackground()
        createHero()
        createGround()
        createWall()
        createAudio()
        startSpawn()
        addChild(heroNode)
        addChild(groundNode)
        addChild(wallNode)
        addChild(secondWallNode)
        addChild(musicNode)
    }
    
    func addBackgroundLayer(texture: SKTexture, speed: TimeInterval, zPosOffset: CGFloat) {
        let node = SKNode()
        let moveBackground = SKAction.moveBy(x: -texture.size().width, y: 0, duration: speed)
        let replaceBackground = SKAction.moveBy(x: texture.size().width, y: 0, duration: 0)
        let moveBackgroundInf = SKAction.repeatForever(SKAction.sequence([moveBackground, replaceBackground]))
        
        for i in 0..<3 {
            let sprite = SKSpriteNode(texture: texture)
            sprite.position = CGPoint(x: size.width / 4 + texture.size().width * CGFloat(i), y: size.height / 2)
            sprite.size.height = self.frame.height
            sprite.zPosition = -zPosOffset
            sprite.run(moveBackgroundInf)
            node.addChild(sprite)
        }
        backGroundNodeArray.append(node)
        addChild(node)
    }
    
    func addBackground() {
        var index = 0
        for text in textures.bgLayerTextures {
            addBackgroundLayer(texture: text.0, speed: TimeInterval(text.1), zPosOffset: CGFloat(index))
            index += 1
        }
    }
    
    func createGround() {
        groundSpriteNode.position = CGPoint.zero
        groundSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width * 2, height: 60))
        groundSpriteNode.physicsBody?.isDynamic = false
        groundSpriteNode.physicsBody?.categoryBitMask = groundMask
        groundSpriteNode.zPosition = 1
        
        groundNode.addChild(groundSpriteNode)
    }
    
    func createWall() {
        wallSpriteNode.position = CGPoint.zero
        wallSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: size.height * 2))
        wallSpriteNode.physicsBody?.isDynamic = false
        wallSpriteNode.physicsBody?.categoryBitMask = wallMask
        wallSpriteNode.zPosition = 1
        
        secondWallSpriteNode.position = CGPoint(x: size.width + 60, y: 0)
        secondWallSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: size.height * 2))
        secondWallSpriteNode.physicsBody?.isDynamic = false
        secondWallSpriteNode.physicsBody?.categoryBitMask = wallMask
        secondWallSpriteNode.zPosition = 1
        
        secondWallNode.addChild(secondWallSpriteNode)
        wallNode.addChild(wallSpriteNode)
    }
    
    func addHero(at position: CGPoint) {
        heroSpriteNode = SKSpriteNode(texture: heroNodeTexture)
        let heroRunAnimation = SKAction.animate(with: textures.heroRunTextureArray, timePerFrame: 0.1)
        let heroRun = SKAction.repeatForever(heroRunAnimation)
        heroSpriteNode.run(heroRun)
        
        heroSpriteNode.position = position
        heroSpriteNode.zPosition = 1
        heroSpriteNode.setScale(1.5)
        
        
        heroSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: heroNodeTexture.size().width - 30, height: heroNodeTexture.size().height + 10))
        heroSpriteNode.physicsBody?.mass = 0.3
        heroSpriteNode.physicsBody?.categoryBitMask = heroMask
        heroSpriteNode.physicsBody?.contactTestBitMask = groundMask
        heroSpriteNode.physicsBody?.collisionBitMask = groundMask
        
        
        heroSpriteNode.physicsBody?.isDynamic = true
        heroSpriteNode.physicsBody?.allowsRotation = false
        
        heroNode.addChild(heroSpriteNode)
    }
    
    func createHero() {
        addHero(at: CGPoint(x: size.width / 2, y: size.height / 4))
    }
    
    func createAudio() {
        guard let musicURL = Bundle.main.url(forResource: "makai-symphony-dragon-slayer", withExtension: "mp3") else {
            fatalError()
        }
        musicNode = SKAudioNode(url: musicURL)
        musicNode.autoplayLooped = true
        musicNode.run(SKAction.play())
    }
    
    func createEnemy(height: CGFloat) {
        let enemyNode = SKNode()
        let enemySpriteNode = SKSpriteNode(texture: textures.enemyTexture[0])
        let enemyAnimation = SKAction.animate(with: textures.enemyTexture, timePerFrame: 0.1)
        let enemyAnimationRepeat = SKAction.repeatForever(enemyAnimation)
        enemySpriteNode.run(enemyAnimationRepeat)
        
        enemySpriteNode.position = CGPoint(x: size.width, y: height)
        enemySpriteNode.zPosition = 1
        enemySpriteNode.xScale *= -1
        
        enemySpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: textures.enemyTexture[0].size().width, height: textures.enemyTexture[0].size().height))
        enemySpriteNode.physicsBody?.categoryBitMask = enemyMask
        enemySpriteNode.physicsBody?.contactTestBitMask = heroMask
        enemySpriteNode.physicsBody?.collisionBitMask = groundMask
        
        enemySpriteNode.physicsBody?.isDynamic = true
        enemySpriteNode.physicsBody?.affectedByGravity = false
        enemySpriteNode.physicsBody?.allowsRotation = false
        
        let move = SKAction.applyImpulse(CGVector(dx: -100, dy: 0), duration: 10)
        enemySpriteNode.run(move)
        
        enemyNodeArray.append(enemyNode)
        enemyNode.addChild(enemySpriteNode)
        addChild(enemyNode)
    }
    
    func heroJump(tapPos: CGPoint) {
        heroInAir = true
        jumpCount += 1
        let jumpAnimation = SKAction.animate(with: textures.heroJumpTextureArray, timePerFrame: 0.1)
        heroSpriteNode.run(jumpAnimation)
        heroSpriteNode.physicsBody?.velocity = CGVector.zero
        
        let xTar = size.width / 2 < tapPos.x ? 1 : -1
        
        heroSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 100 * xTar, dy: 120))
    }

    func heroDied() {
        let deathAnim = SKAction.animate(with: textures.deathTextureArray, timePerFrame: 0.1)
        heroSpriteNode.run(deathAnim)
    }
    
    func startSpawn() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.createEnemy(height: CGFloat.random(in: 0...self.size.height - 50))
        }
    }
    
    func endGame() {
        if gameIsPaused == true {
            timer.invalidate()
            children.forEach { node in
                node.removeAllActions()
                node.children.forEach { node in
                    node.removeAllActions()
                }
            }
            
            musicNode.run(SKAction.stop())
            enemyNodeArray.forEach { node in
                node.removeFromParent()
            }
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                let blurView = UIVisualEffectView(frame: self.frame)
                blurView.alpha = 1
                blurView.layer.zPosition = 2
                self.gameVC?.view.addSubview(blurView)
                UIView.animate(withDuration: 3) {
                    blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                } completion: { _ in
                    let vc = self.gameVC?.storyboard?.instantiateViewController(identifier: "startVC") as! StartViewController
                    self.gameVC?.present(vc, animated: false, completion: nil)
                    self.gameVC?.removeFromParent()
                }
            }
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            heroInAir = false
            jumpCount = 0
            if gameIsPaused {
                physicsWorld.gravity = CGVector(dx: 0, dy: -10)
            }
        }
        
        if contact.bodyA.categoryBitMask == 4 && contact.bodyB.categoryBitMask == 1 || contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 4 {
            gameIsPaused = true
            heroDied()
            physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        }
        
        if contact.bodyA.categoryBitMask == 4 && contact.bodyB.categoryBitMask == 3 || contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 4 {
            if contact.bodyA.categoryBitMask == 4 {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
        }
    }
}

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !gameIsPaused {
            if jumpCount < 3 {
                heroJump(tapPos: (touches.first!.location(in: self.view)))
            }
        }
    }
}
