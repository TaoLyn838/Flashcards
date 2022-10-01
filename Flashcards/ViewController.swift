//
//  ViewController.swift
//  Flashcards
//
//  Created by Tao Lin on 9/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var choice_a: UIButton!
    @IBOutlet weak var choice_b: UIButton!
    @IBOutlet weak var choice_c: UIButton!
    let DefaultBackgroundCol = UIColor.white
    let DefaultTextCol = UIColor.black
    var toggle = true;
    
    // Lab2
    var DefButtonCol: UIColor!
    
    
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
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        fliped()
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
    
    
    // Making it not crash!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcaardsController = self
    }
    
    func fliped () {
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
        
        frontLabel.text = question
        backLabel.text = opA
        choice_a.setTitle(opA, for: .normal)
        choice_b.setTitle(opB, for: .normal)
        choice_c.setTitle(opC, for: .normal)
    }
    
    func resetMainUI () {
        choice_a.backgroundColor = DefButtonCol
        choice_b.backgroundColor = DefButtonCol
        choice_c.backgroundColor = DefButtonCol
        if toggle == false {
            fliped()
        }
    }
}
