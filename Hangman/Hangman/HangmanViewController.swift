//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit



class HangmanViewController: UIViewController {
    //set up, the gamepicture and wordPicked text
    var gameC:GameController? = nil
    @IBOutlet weak var hangMPicture: UIImageView!
    
    @IBOutlet weak var Dieplaywords: UILabel!
    
    @IBOutlet weak var guessedWordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        InitialSetUp()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func InitialSetUp() {
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
        gameC = GameController(ObjWord: phrase)
        hangMPicture.image = UIImage(named: "hangman1")
        Dieplaywords.text = (gameC?.getWordDisplay())!
        guessedWordLabel.text = "Words Guessed:" + (gameC?.getWordGuessed ())!
    }
    @IBAction func ReplayButtonPressed(_ sender: UIButton) {
        InitialSetUp()
    }
    
    
    @IBAction func PickedWord(_ sender: UITextField) {
        if let pickWord = sender.text{
            let pickChar = Character(pickWord)
            //do things with the picked text
            if (gameC?.isOver() == true) {//the game already over
                return
            } else if (gameC?.canPickWord(ObjWord: pickChar) == true) {//this func returns true if we select a new word that hasn't been selected(can be correct or wrong)
                if (gameC?.checkIsCorrect(ObjWord: pickChar) == true) {
                    gameC?.addWordCorrect(ObjWord: pickChar)
                } else {
                    gameC?.addWordWrong(ObjWord: pickChar)
                }
                //after adding the word we deal with the display things(change the picture&text)
                hangMPicture.image = UIImage(named: (gameC?.getPicDisplay())!)
                Dieplaywords.text = gameC?.getWordDisplay()
                
                guessedWordLabel.text = "Word Guessed:" + (gameC?.getWordGuessed ())!
                //after game over, change texts and display win state, ask restart
                if (gameC?.isOver() == true) {//the game already over
                    if (gameC?.IsWin == true) {
                        guessedWordLabel.text = "GameOver! You Win"
                    } else {
                        guessedWordLabel.text = "GameOver! You Lose"
                    }
                    
                    return
                }
            }
        } else {//the selected word already been selected
            return
        }
    }
    
//********************* Alert Message Things *******************
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
