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
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if backLabel.backgroundColor != DefaultBackgroundCol {
            backLabel.backgroundColor = DefaultBackgroundCol
        }
        if backLabel.textColor != DefaultTextCol {
            backLabel.textColor = DefaultTextCol
        }
        frontLabel.isHidden = toggle;
        toggle = !toggle
    }
    
    @IBAction func TapChoiceButton(_ sender: UIButton) {
        if backLabel.tag == sender.tag {
            frontLabel.isHidden = true
            sender.backgroundColor = UIColor.systemTeal
            backLabel.backgroundColor = UIColor.systemTeal
            backLabel.textColor = UIColor.white
        } else {
            sender.backgroundColor = UIColor.red
        }
    }
}
