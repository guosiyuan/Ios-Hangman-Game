//
//  GameController.swift
//  Hangman
//
//  Created by siyuan on 2/27/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation
class GameController {

    var ObjectiveWord = [Character]()
    var ObjectiveWordDisplay = [String]()
    var WordGuessed = [Character]()
    var IsOver = false
    var IsWin = false
    var WrongTime = 0
    
    init(ObjWord:String) {
        self.ObjectiveWord = Array(ObjWord.characters)
        self.ObjectiveWordDisplay = Array(repeating: "_", count: self.ObjectiveWord.count)
        self.WrongTime = 0
    }
    
    func isOver()-> Bool {
        return IsOver
    }
    
    func canPickWord(ObjWord:Character)-> Bool {
        return !WordGuessed.contains(ObjWord)
    }
    
    func checkIsCorrect(ObjWord: Character)-> Bool {
        return ObjectiveWord.contains(ObjWord)
    }

    func addWordCorrect(ObjWord: Character) {
        WordGuessed += [ObjWord]
        var i = 0
        for char in ObjectiveWord{//update display
            if (char == ObjWord) {
                ObjectiveWordDisplay[i] = String(char)
            }
            i+=1
        }
        //chesk is over
        checkIsOver()
    }
    
    func addWordWrong(ObjWord: Character) {
        WordGuessed += [ObjWord]
        WrongTime += 1
        checkIsOver()
    }
    
    
    func checkIsOver(){
        if (WrongTime == 6) {
            IsOver = true
            IsWin = false
            return
        } else{//not lose
            IsOver = true
            IsWin = true
            for cchar in ObjectiveWord {
                if (!WordGuessed.contains(cchar) && (cchar != " ")) {
                    IsOver = false
                    IsWin = false
                    return
                }
            }
        }
    }
    
    func getPicDisplay() -> String {
        return "hangman" + String(WrongTime+1)
    }
    
    func getWordDisplay() -> String {
        return ObjectiveWordDisplay.joined(separator: ",")
    }
    
    func getWordGuessed () -> String {
        return String(WordGuessed)
    }
}
