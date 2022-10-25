//
//  CreationViewController.swift
//  Flashcards
//
//  Created by CHENGTAO on 9/27/22.
//

import UIKit

class CreationViewController: UIViewController {
    var flashcaardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var option1: UITextField!
    @IBOutlet weak var option2: UITextField!
    @IBOutlet weak var option3: UITextField!
    
    private var canEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        flashcaardsController.resetMainUI()
        canEdit = flashcaardsController.canEdit
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        let opA = option1.text
        let opB = option2.text
        let opC = option3.text
        if (opA?.count == 0) || (opB?.count == 0) || (opC?.count == 0) {
            let ac = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answers", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            flashcaardsController.updateFlashcard(question: questionText!, opA: opA!, opB: opB!, opC: opC!, isEdit: canEdit)
                flashcaardsController.saveAllFlashcardsToDisk()
            dismiss(animated: true)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
