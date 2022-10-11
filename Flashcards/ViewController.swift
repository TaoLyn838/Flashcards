//
//  ViewController.swift
//  Flashcards
//
//  Created by Tao Lin on 9/11/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var optionA: String
    var optionB: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var choice_a: UIButton!
    @IBOutlet weak var choice_b: UIButton!
    @IBOutlet weak var choice_c: UIButton!
    let DefaultBackgroundCol = UIColor.white
    let DefaultTextCol = UIColor.black
    private var toggle = true;
    
    // Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var currentIndex = 0
    
    // Lab2
    var DefButtonCol: UIColor!
    
    // Buttons for moving flashcard
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Rounded Button
        choice_a.layer.cornerRadius = 20
        choice_a.layer.masksToBounds = true
        choice_b.layer.cornerRadius = 20
        choice_b.layer.masksToBounds = true
        choice_c.layer.cornerRadius = 20
        choice_c.layer.masksToBounds = true
        DefButtonCol = choice_a.backgroundColor
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the Katakana of お?", opA: "オ", opB: "カ", opC: "二")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipped()
    }
        
    @IBAction func TapChoiceButton(_ sender: UIButton) {
        if backLabel.tag == sender.tag {
            toggle = false
            frontLabel.isHidden = true
            sender.backgroundColor = UIColor.systemTeal
            backLabel.backgroundColor = UIColor.systemTeal
            backLabel.textColor = UIColor.white
        } else {
            sender.backgroundColor = UIColor.red
        }
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex += 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex -= 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    
    
    // Making it not crash!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcaardsController = self
    }
    
    private func flipped () {
        if backLabel.backgroundColor != DefaultBackgroundCol {
            backLabel.backgroundColor = DefaultBackgroundCol
        }
        if backLabel.textColor != DefaultTextCol {
            backLabel.textColor = DefaultTextCol
        }
        frontLabel.isHidden = toggle;
        toggle = !toggle
    }
    
    func updateFlashcard(question: String, opA: String, opB: String, opC: String) {
        let flashcard = Flashcard(question: question, answer: opA, optionA: opB, optionB: opC)
        
        flashcards.append(flashcard)
        
        print("we now have \(flashcards.count) flashcard")
        
        // update fashcard current index
        currentIndex = flashcards.count - 1
        
        //update buttons
        updateNextPrevButtons()
        
        updateLabels()
        
        print(flashcards)
    }
    
    func resetMainUI () {
        choice_a.backgroundColor = DefButtonCol
        choice_b.backgroundColor = DefButtonCol
        choice_c.backgroundColor = DefButtonCol
        if toggle == false {
            flipped()
        }
    }
    
    private func updateNextPrevButtons() {
        currentIndex == flashcards.count - 1 ? (nextButton.isEnabled = false) : (nextButton.isEnabled = true)
        
        currentIndex == 0 ? (prevButton.isEnabled = false) : (prevButton.isEnabled = true)
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
                
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        choice_a.setTitle(currentFlashcard.answer, for: .normal)
        choice_b.setTitle(currentFlashcard.optionA, for: .normal)
        choice_c.setTitle(currentFlashcard.optionB, for: .normal)
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map{(card) -> [String: String] in return ["question": card.question, "answer": card.answer, "optionA": card.optionA, "optionB": card.optionB]}
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            // In here we know for sure we have a dictionary arrary
            let saveCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, optionA: dictionary["optionA"]!, optionB: dictionary["optionB"]!)}
            
            // Put all these cards in our flashcards arrary
            flashcards.append(contentsOf: saveCards)
        }
    }
    
}
