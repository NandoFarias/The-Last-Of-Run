//
//  Zumbi.swift
//  The Last of Run
//
//  Created by Rodrigo Ota on 22/03/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation

// MARK: - Class Definition
class Zumbi : CCSprite {
    // MARK: - Public Objects
    internal var eventSelector:Selector?
    internal var targetID:AnyObject?
    
    
    // MARK: - Private Objects
    private var spriteZumbi:CCSprite?
    private var spriteZumbiAtropelado:CCSprite = CCSprite(imageNamed: "zumbi7.png")
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        // Cria o sprite da barata animado
        self.spriteZumbi = self.gerarAnimacaoSpriteWithName("zumbi", aQtdFrames: 6)
        self.spriteZumbi!.anchorPoint = CGPointMake(0.5, 0.5);
        self.spriteZumbi!.position = CGPointMake(0.0, 0.0);
        self.addChild(self.spriteZumbi, z:2)
        
        self.spriteZumbiAtropelado.opacity = 0.0
        self.spriteZumbiAtropelado.anchorPoint = CGPointMake(0.5, 0.5);
        self.spriteZumbiAtropelado.position = CGPointMake(0.0, 0.0);
        self.addChild(self.spriteZumbiAtropelado, z:1)

        // Configuracoes default
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.spriteZumbi!.contentSize.width/2, self.spriteZumbi!.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.1
        self.physicsBody.mass = 100.0
        self.physicsBody.density = 100.0
        self.physicsBody.collisionType = "Zumbi"
        self.physicsBody.collisionCategories = ["Zumbi"]
        self.physicsBody.collisionMask = ["PlayerCar"]
        
    }
    
    override init(CGImage image: CGImage!, key: String!) {
        super.init(CGImage: image, key: key)
    }
    
    override init(spriteFrame: CCSpriteFrame!) {
        super.init(spriteFrame: spriteFrame)
    }
    
    override init(texture: CCTexture!) {
        super.init(texture: texture)
    }
    
    override init(texture: CCTexture!, rect: CGRect) {
        super.init(texture: texture, rect: rect)
    }
    
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) {
        super.init(texture: texture, rect: rect, rotated: rotated)
    }
    
    override init(imageNamed imageName: String!) {
        super.init(imageNamed: imageName)

    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    convenience init(event:Selector, target:AnyObject) {
        self.init()
        
        self.eventSelector = event
        self.targetID = target
    }
    
    // MARK: - Private Methods
    func gerarAnimacaoSpriteWithName(aSpriteName:String, aQtdFrames:Int) -> CCSprite {
        // Carrega os frames da animacao dentro do arquivo passado dada a quantidade de frames
        var animFrames:Array<CCSpriteFrame> = Array()
        for (var i = 1; i <= aQtdFrames; i++) {
            let name:String = "\(aSpriteName)\(i).png"
            animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }
        // Cria a animacao dos frames montados
        let animation:CCAnimation = CCAnimation(spriteFrames: animFrames, delay: 0.1)
        // Cria a acao com a animacao dos frames
        let animationAction:CCActionAnimate = CCActionAnimate(animation: animation)
        // Monta a repeticao eterna da animacao
        let actionForever:CCActionRepeatForever = CCActionRepeatForever(action: animationAction)
        // Monta o sprite com o primeiro quadro
        var spriteRet:CCSprite = CCSprite(imageNamed: "\(aSpriteName)\(1).png")
        // Executa a acao da animacao
        spriteRet.runAction(actionForever)
        
        // Retorna o sprite para controle na classe
        return spriteRet
    }
    
    // MARK: - Public Methods
    // MARK: - Public Methods
    internal func moveMe(vel : CGFloat) {
        let speed:CGFloat = vel
        self.runAction(CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(CCTime(speed), position: CGPointMake(self.position.x, self.height() * -2)) as CCActionFiniteTime,
            two: CCActionCallBlock.actionWithBlock({ _ in
                self.stopAllSpriteActions()
                self.removeFromParentAndCleanup(true)
            }) as CCActionFiniteTime)
            as CCAction)
    }
    
    internal func runOver() {
        // Barulho da batida
        //OALSimpleAudio.sharedInstance().playEffect("FXSquitch.mp3")
        
        // Apresenta o blood e oculta a barata
        self.spriteZumbiAtropelado.opacity = 255.0
        self.spriteZumbi?.opacity = 0.0
    self.spriteZumbiAtropelado.runAction(CCActionSequence.actionOne(CCActionFadeOut.actionWithDuration(5) as CCActionFiniteTime, two: CCActionCallBlock.actionWithBlock({ _ in
            self.removeFromParentAndCleanup(true)
        }) as CCActionFiniteTime) as CCAction)
        
        // Mata o zumbi e executa o evento informado
        //DelayHelper.sharedInstance.callFunc(self.eventSelector!, onTarget: self.targetID!, withDelay: 0.0)
    }
    
    internal func stopAllSpriteActions() {
        self.stopAllActions()
        self.stopAllActions()
    }
    
    internal func width() -> CGFloat {
        return self.boundingBox().size.width
    }
    
    internal func height() -> CGFloat {
        return self.boundingBox().size.height
    }
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }
}