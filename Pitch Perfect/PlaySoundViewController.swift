//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Chris Aardal on 6/30/15.
//  Copyright (c) 2015 Chris Aardal. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    var engine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

//        if var filepath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"   ) {
//            var url = NSURL.fileURLWithPath(filepath)
//            
//            
//        } else {
//            println("Couldnt find the filepath")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        engine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func heellooo() {
        println("wazuuuup") 
    }
    
    
    @IBAction func snailAction(sender: UIButton) {
        playAudio(0.5)
        heellooo()
    }
    
    
    @IBAction func fastAction(sender: UIButton) {
        playAudio(2.0)
    }
    
    @IBAction func chipmunkAction(sender: UIButton) {
        pitchAudio(1000)
    }

    @IBAction func stopPlaying(sender: UIButton) {
        stopAudio()
    }
    
    @IBAction func vaderAction(sender: UIButton) {
        pitchAudio(-1000)
    }
    func playAudio(rate:Float) {
        if audioPlayer.playing {
            audioPlayer.stop()
        }
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func stopAudio() {
        if audioPlayer.playing {
            audioPlayer.currentTime = 0
            audioPlayer.stop()
        }
    }
    
    func pitchAudio(pitch:Float) {
        audioPlayer.stop()
        engine.stop()
        engine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        engine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        engine.attachNode(changePitchEffect)
        
        engine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        engine.connect(changePitchEffect, to: engine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        engine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }

}
