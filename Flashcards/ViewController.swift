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

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    
    @IBOutlet weak var choice_a: UIButton!
    @IBOutlet weak var choice_b: UIButton!
    @IBOutlet weak var choice_c: UIButton!
    let DefaultBackgroundCol = UIColor.white
    let DefaultTextCol = UIColor.black
    private var toggle = true
    var canEdit = false
    
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
        
        //Rounded and shadow Label and Button
        designLabel(label: frontLabel)
        designLabel(label: backLabel)
        designButton(botton: choice_a)
        designButton(botton: choice_b)
        designButton(botton: choice_c)
        DefButtonCol = choice_a.backgroundColor
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.card.transform = .init(scaleX: 1.25, y: 1.25)
        }) { (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.card.transform = .identity
            })
        }
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the Katakana of お?",
                            opA: "オ",
                            opB: "カ",
                            opC: "二",
                            isEdit: false
            )
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    /*
     ***********************************************************
                            UI
     ***********************************************************
    */
    
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
        print(backLabel.tag)
        print(sender.tag)
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex += 1
        
        //updateLabels()
        animateCardOut(duration: 0.4, hori: -400.0, vert: 0.0)
        resetMainUI ()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex -= 1
        
        animateCardOut(duration: 0.4, hori: 400.0, vert: 0.0)
        resetMainUI ()
        updateNextPrevButtons()
    }
    
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        deleteCard()
        print(flashcards.count)
        
    }
    
    @IBAction func didTapOnEdit(_ sender: Any) {
//        let creationController = storyboard?.instantiateViewController(withIdentifier: "Creation_VC") as! CreationViewController
        canEdit = true
    }
        
    
    private func flipped () {
        if backLabel.backgroundColor != DefaultBackgroundCol {
            backLabel.backgroundColor = DefaultBackgroundCol
        }
        if backLabel.textColor != DefaultTextCol {
            backLabel.textColor = DefaultTextCol
        }
        labelAnimationController();
        toggle = !toggle
    }
    
    func resetMainUI () {
        choice_a.backgroundColor = DefButtonCol
        choice_b.backgroundColor = DefButtonCol
        choice_c.backgroundColor = DefButtonCol
        if toggle == false {
            flipped()
        }
    }
    
    func designButton(botton: UIButton) {
        botton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        botton.layer.shadowOpacity = 1.0
        botton.layer.shadowRadius = 0.0
        botton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        botton.layer.masksToBounds = false
        botton.layer.cornerRadius = 20
    }
    
    func designLabel(label: UILabel) {
        label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 0.0
        label.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 20
    }
    
    /*
     ***********************************************************
                            Animation
     ***********************************************************
    */
    
    //Label flip right animation
    private func labelAnimationController() {
        UIView.transition(with: card, duration: 0.4, options: .transitionFlipFromRight, animations: {self.frontLabel.isHidden = self.toggle})
    }
    
    func animateCardOut(duration: TimeInterval, hori: CGFloat, vert: CGFloat) {
        UIView.animate(
            withDuration: duration,
            animations: {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: hori, y: vert)
            },
            completion: {
                finished in
                self.updateLabels()
                self.animateCardIn(duration: duration, hori: hori, vert: vert)
            }
        )}
    
    func animateCardIn(duration: TimeInterval, hori: CGFloat, vert: CGFloat) {

        card.transform = CGAffineTransform.identity.translatedBy(x: -hori, y: vert)
    
        UIView.animate(withDuration: duration) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    
    /*
     ***********************************************************
                            Update
     ***********************************************************
    */
    
    func updateFlashcard(question: String, opA: String, opB: String, opC: String, isEdit: Bool) {
        if (isEdit) {
            flashcards[currentIndex].question = question
            flashcards[currentIndex].answer = opA
            flashcards[currentIndex].optionA = opB
            flashcards[currentIndex].optionB = opC
            updateLabels()
            
            canEdit = false
            
        } else {
            let flashcard = Flashcard(question: question, answer: opA, optionA: opB, optionB: opC)
            flashcards.append(flashcard)
            
            // print("we now have \(flashcards.count) flashcard")
            
            // update fashcard current index
            currentIndex = flashcards.count - 1
            
            //update buttons
            updateNextPrevButtons()
            
            updateLabels()
        }
        
        print(flashcards)
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
    
    /*
     ***********************************************************
                            Data controllor
     ***********************************************************
    */
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
    
    func deleteCard() {
        let ac = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .alert)
        let delAc = UIAlertAction(title: "Yes", style: .cancel) {action in self.toDelete()}
        let undoAc = UIAlertAction(title: "Undo", style: .destructive)
        
        ac.addAction(undoAc)
        ac.addAction(delAc)
        
        present(ac, animated: true)
    }
    
    // deleteCard helper
    private func toDelete() {
        if flashcards.count == 1 {
            let ac = UIAlertController(title: "😅", message: "Cannot delete this flashcard because currently only has \(flashcards.count) flashcard.", preferredStyle: .alert)
            let undoAc = UIAlertAction(title: "back", style: .default)
            
            ac.addAction(undoAc)
            
            present(ac, animated: true)
            return
        }
        
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
                
        updateLabels()
                
        saveAllFlashcardsToDisk()
    }
    
    
    
    
    /*
     ***********************************************************
                            Others
     ***********************************************************
    */
    
    // Making it not crash!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcaardsController = self
    }
}
