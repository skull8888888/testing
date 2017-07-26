//
//  Test.swift
//  ENT
//
//  Created by Dinmukhammed on 17.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit
import SQLite
import PMAlertController

class Test: UIViewController {


    var questions: [Question] = []
    var curQuestion = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
   // let alertVC = PMAlertController(title: "A Title", description: "My Description", image: UIImage(#imageLiteral(resourceName: "success")), style: .alert)
   
   
    
    
    @IBOutlet var ansLabelText: [UIButton]!
    
    @IBOutlet weak var favLabel: UIButton!
    @IBAction func favFunc(_ sender: UIButton) {
        
        
        
    }
    
 
    
    @IBAction func exitToMain(_ sender: UIButton) {
        
        let alertVC = PMAlertController(title: "Выйти в главное меню?", description: "Результат не будет сохранен", image: nil, style: .alert)
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("Capture action Cancel")
        }))
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            print("Capture action OK")
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            
        }))
        
     //   alertVC.setNeedsStatusBarAppearanceUpdate() = false
      
        self.present(alertVC, animated: false, completion: nil)
    
        
    }
    
    
    
    
    
    @IBOutlet weak var curQuestNumberLabel: UILabel!
    @IBOutlet weak var backButtonLabel: UIButton!
    @IBOutlet weak var forwardButtonLabel: UIButton!
    
    @IBOutlet weak var subFrame: UIView!

    @IBOutlet var ansLabelTick: [UIButton]!
    
    
    
    @IBAction func prevQuest(_ sender: UIButton) {
        if curQuestion > 0{
            curQuestion -= 1
        }
        showQuestion()
        
    }
    @IBAction func nextQuest(_ sender: UIButton) {
        if curQuestion < 24{
            curQuestion += 1
        }
        showQuestion()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load_questions()
        showQuestion()
     
        subFrame.layer.cornerRadius = 4
        
        backButtonLabel.roundCorners(corners: [.bottomLeft,.topLeft], radius: 4)
        forwardButtonLabel.roundCorners(corners: [.bottomRight,.topRight], radius: 4)
        
        
        subFrame.layer.shadowColor = UIColor.black.cgColor
        subFrame.layer.shadowOpacity = 0.15
        subFrame.layer.shadowOffset = CGSize.zero
        subFrame.layer.shadowRadius = 10
        
        for i in 0...4{
            ansLabelTick[i].setImage(#imageLiteral(resourceName: "success"), for: .highlighted)
            
        }
        

        
        view.addBackground()
  
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    @IBAction func choose(_ sender: UIButton) {
        
        
        if curQuestion >= 24 {
            performSegue(withIdentifier: "toResult", sender: self)
            return
        }
 
     
        questions[curQuestion].choosenAnswer = sender.tag
        curQuestion += 1
        showQuestion()
        
    }
    
    func load_questions(){
        
        let path = Bundle.main.path(forResource: "ent", ofType: "db")!
        let db = try? Connection(path, readonly: true)
        for i in 0...24{
            
            // generating random sequence of 5 integers to get random pattern
            // of answers
            var sequence:[Int] = []
            
            while sequence.count != 5 {
                
                let randomNum:Int = Int(arc4random_uniform(5))
        
                if sequence.contains(randomNum){
                    continue
                }
                
                sequence.append(randomNum)
            }
            
            for row in try! db!.prepare("SELECT _id, v, a, b,c,d,e FROM IstRusTest WHERE _id = ABS(RANDOM() % 3300)") {
                
                var answers: [String] = []
                
                answers.append(row[2] as! String)
                answers.append(row[3] as! String)
                answers.append(row[4] as! String)
                answers.append(row[5] as! String)
                answers.append(row[6] as! String)
                
                let question = Question(id: row[0] as! Int64,
                                        quest: row[1] as! String,
                                        ans: answers as [String],
                                        seq: sequence as [Int])
                
                questions.append(question)
                
            }
            print(questions[i].sequenceOfNumbers)
            
        }
        
        
    }
    
    func showQuestion(){
   
        curQuestNumberLabel.text = String(curQuestion + 1)
        questionLabel.text = questions[curQuestion].quest
        let curSequence = questions[curQuestion].sequenceOfNumbers
        
        
        let index = questions[curQuestion].choosenAnswer
        if index > 0 {
            for i in 0...4{
                ansLabelTick[i].setImage(#imageLiteral(resourceName: "success_unchecked"), for: .normal)
            }
            ansLabelTick[index].setImage(#imageLiteral(resourceName: "success"), for: .normal)
            
        } else{
            for i in 0...4{
                ansLabelTick[i].setImage(#imageLiteral(resourceName: "success_unchecked"), for: .normal)
            }
        }
        
        for i in 0...4{
            ansLabelText[i].setTitle(questions[curQuestion].ans[curSequence[i]], for: .normal)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult"{
            let nc = segue.destination as! UINavigationController
            let dvc: ResultViewController = nc.topViewController as! ResultViewController
            dvc.ansByUser = questions
        }
    }
    
}


