import Foundation
import SpriteKit

class Textures {
    let heroRunTextureArray : [SKTexture] = [SKTexture(imageNamed: "Warrior_Run_1"),
                                             SKTexture(imageNamed: "Warrior_Run_2"),
                                             SKTexture(imageNamed: "Warrior_Run_3"),
                                             SKTexture(imageNamed: "Warrior_Run_4"),
                                             SKTexture(imageNamed: "Warrior_Run_5"),
                                             SKTexture(imageNamed: "Warrior_Run_6"),
                                             SKTexture(imageNamed: "Warrior_Run_7"),
                                             SKTexture(imageNamed: "Warrior_Run_8"),
    ]
    
    let heroJumpTextureArray : [SKTexture] = [SKTexture(imageNamed: "Warrior_Jump_1"),
                                             SKTexture(imageNamed: "Warrior_Jump_2"),
                                             SKTexture(imageNamed: "Warrior_Jump_3"),
                                             SKTexture(imageNamed: "Warrior_UptoFall_1"),
                                             SKTexture(imageNamed: "Warrior_UptoFall_2"),
                                             SKTexture(imageNamed: "Warrior_Fall_1"),
    ]

    let bgLayerTextures : [(SKTexture, CGFloat)]  = [(SKTexture(imageNamed: "Layer_0000_9"), 3),
                                                     (SKTexture(imageNamed: "Layer_0001_8"), 3),
                                                     (SKTexture(imageNamed: "Layer_0002_7"), 3),
                                                     (SKTexture(imageNamed: "Layer_0003_6"), 3),
                                                     (SKTexture(imageNamed: "Layer_0004_Lights"), 2.5),
                                                     (SKTexture(imageNamed: "Layer_0005_5"), 4),
                                                     (SKTexture(imageNamed: "Layer_0006_4"), 4),
                                                     (SKTexture(imageNamed: "Layer_0007_Lights"), 3.5),
                                                     (SKTexture(imageNamed: "Layer_0008_3"), 5),
                                                     (SKTexture(imageNamed: "Layer_0009_2"), 5),
                                                     (SKTexture(imageNamed: "Layer_0010_1"), 5)
    ]
    
    let deathTextureArray: [SKTexture] = [SKTexture(imageNamed: "Warrior_Death_1"),
                                          SKTexture(imageNamed: "Warrior_Death_2"),
                                          SKTexture(imageNamed: "Warrior_Death_3"),
                                          SKTexture(imageNamed: "Warrior_Death_4"),
                                          SKTexture(imageNamed: "Warrior_Death_5"),
                                          SKTexture(imageNamed: "Warrior_Death_6"),
                                          SKTexture(imageNamed: "Warrior_Death_7"),
                                          SKTexture(imageNamed: "Warrior_Death_8"),
                                          SKTexture(imageNamed: "Warrior_Death_9"),
                                          SKTexture(imageNamed: "Warrior_Death_10"),
                                          SKTexture(imageNamed: "Warrior_Death_11"),
    ]
    
    let enemyTexture: [SKTexture] = [SKTexture(imageNamed: "fly01"),
                                     SKTexture(imageNamed: "fly02"),
                                     SKTexture(imageNamed: "fly03"),
                                     SKTexture(imageNamed: "fly04"),
                                     SKTexture(imageNamed: "fly05"),
                                     SKTexture(imageNamed: "fly06"),
                                     SKTexture(imageNamed: "fly07")
    ]
}
