//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by Dingnan Zhou on 9/5/17.
//  Copyright © 2017 Dingnan Zhou. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet weak var awesomeimage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    var awesomePlayer = AVAudioPlayer()
    var index = -1
    var imageNumber = -1
    var soundNumber = -1
    let numberOfImages = 5
    let numberOfSounds = 6
    var soundName = ""
    
    //FIXME: -Please repair this error
    //TODO: -Update viewDidLoad
    //This code executes when the view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - My Own Functions
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        // Can we load in the file soundName
        if let sound = NSDataAsset(name:soundName){
            // check if sound.data is a sound file
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                //if sound.data is not a valid audio file
                print("ERROR: data in \(soundName) couldn't be played")
            }
        } else {
            //if reading in the NSDataAsset didn't work, tell the user/report the error.
            print("ERROR: file\(soundName) didn't load")
        }
        
    }

    func nonRepeatingRandom(lastNumber: Int, maxValue: Int) ->Int {
        var newIndex = -1
        repeat {
            newIndex = Int(arc4random_uniform(UInt32(maxValue)))
        } while index == newIndex
        return newIndex
    }
    //MARK: -Actions
    @IBAction func soundSwtichPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn {
            if soundNumber != -1 {
            //stop playing
            awesomePlayer.stop()
            }
            
        }
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {

        let messages = ["You Are Fantastic!",
                        "You Are Great!",
                        "You Are Amazing",
                        "When the Genius Bar needs help, they call you!",
                        "You Brighten My Day!",
                        "You Are Da Bomb!",
                        "I can't wait to see your app",
                        "Fabulous? That's You!"]
        
        // Show a message
        index = nonRepeatingRandom(lastNumber: index, maxValue: messages.count)
        messageLabel.text = messages[index]
        
        //Show an image
        awesomeimage.isHidden = false
        
            imageNumber = nonRepeatingRandom(lastNumber: imageNumber, maxValue: numberOfImages)
        awesomeimage.image = UIImage(named: "image\(imageNumber)")
        
        if soundSwitch.isOn {
            //Get a random number to use in our soundName file
            soundNumber = nonRepeatingRandom(lastNumber: soundNumber, maxValue: numberOfSounds)
            
            //play a sound
            soundName = "sound\(soundNumber)"
            playSound(soundName: soundName, audioPlayer: &awesomePlayer)
        }
        
        }
        
}


