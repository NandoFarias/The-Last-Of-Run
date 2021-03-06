//
//  LoadingScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class LoadingScene : CCScene {
	// MARK: - Public Objects

	// MARK: - Private Objects


	// MARK: - Life Cycle
	override init() {
		super.init()

        // Define a cor de fundo da cena
        self.color = CCColor.whiteColor()
        
        // Preload das musicas
        SoundPlayHelper.sharedInstance.preloadSoundsAndMusic()
        SoundPlayHelper.sharedInstance.setMusicDefaultVolume()
        
        
        // Preload do plist
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("zombie.plist")
        
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("playercar.plist")
        
        self.createSceneObjects()
        
        self.firstInitUserDefaults()

	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
	}
    
    func firstInitUserDefaults(){
        var scores : [Int]? = NSUserDefaults.standardUserDefaults().objectForKey("scores") as? [Int]
        if (scores == nil){
            NSUserDefaults.standardUserDefaults().setObject([0,0,0], forKey: "scores")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        var musicSettings : Bool? = NSUserDefaults.standardUserDefaults().objectForKey("musicSettings") as? Bool
        if (musicSettings == nil){
            NSUserDefaults.standardUserDefaults().setObject(true, forKey: "musicSettings")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        var effectsSettings : Bool? = NSUserDefaults.standardUserDefaults().objectForKey("effectsSettings") as? Bool
        if (effectsSettings == nil){
            NSUserDefaults.standardUserDefaults().setObject(true, forKey: "effectsSettings")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        
        
        
    }
    

    // MARK: - Private Methods
    func createSceneObjects() {
        // Label loading
        let background:CCSprite = CCSprite(imageNamed: "bgLoading.png")
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        background.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(background)
        
        // Chama os steps de inicializacao
        DelayHelper.sharedInstance.callFunc("callGameHome", onTarget: self, withDelay: 1.0)
    }
    
    func callGameHome() {
        StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
    }
    
    // MARK: - Public Methods
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    override func onExit() {
        // Chamado quando sai do director
        super.onExit()
        
        CCTextureCache.sharedTextureCache().removeAllTextures()
}
}