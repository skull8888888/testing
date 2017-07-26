//
//  ResultViewController.swift
//  ENT
//
//  Created by Dinmukhammed on 21.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    
     var ansByUser: [Question] = []
     var total = 0
     override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...24{
            let correctAnswer = ansByUser[i].sequenceOfNumbers.index(of: 0)
            if  correctAnswer == ansByUser[i].choosenAnswer {
                total += 1
            }
        }
        
        view.addBackground()
  
    }
    
    
    @IBAction func toMainMenu(_ sender: UIBarButtonItem) {
        self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: {})
        
    }
    
//    override var prefersStatusBarHidden: Bool{
//        return true
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ansByUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resCell", for: indexPath) as! ResultCell
        
        
        cell.questionTextLabel.text = ansByUser[indexPath.row].quest
        cell.curQuestonNumber.text = String(indexPath.row + 1)
        let answer = ansByUser[indexPath.row].choosenAnswer
        
        cell.wrongAnswerText.isHidden = false
        cell.wrongImage.isHidden = false
        let correctAnswer = ansByUser[indexPath.row].sequenceOfNumbers.index(of: 0)
        
        if (answer < 0){
            
            cell.wrongAnswerText.text = "Вы не выбрали ответ"
            cell.wrongImage.image = #imageLiteral(resourceName: "error")
            cell.rightAnswerText.text = ansByUser[indexPath.row].ans[correctAnswer!]
            cell.rightImage.image = #imageLiteral(resourceName: "success")
            
        } else {
            
            let userAnswer = ansByUser[indexPath.row].choosenAnswer
            
            if  correctAnswer == userAnswer {
                
                cell.wrongAnswerText.isHidden = true
                cell.wrongImage.isHidden = true
                cell.rightAnswerText.text = ansByUser[indexPath.row].ans[correctAnswer!]
                cell.rightImage.image = #imageLiteral(resourceName: "success")
                
            } else{
                
                cell.wrongAnswerText.text = ansByUser[indexPath.row].ans[userAnswer]
                cell.wrongImage.image = #imageLiteral(resourceName: "error")
                cell.rightImage.image = #imageLiteral(resourceName: "success")
                cell.rightAnswerText.text = ansByUser[indexPath.row].ans[correctAnswer!]
            }
        }
        cell.contentBlock.layer.masksToBounds = false
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        let selectedCellColor = UIView()
        selectedCellColor.backgroundColor = .clear
        cell.selectedBackgroundView = selectedCellColor
        tableView.separatorStyle = .none
        
        cell.contentBlock.layer.cornerRadius = 4
        
        cell.contentBlock.layer.shadowColor = UIColor.black.cgColor
        cell.contentBlock.layer.shadowOpacity = 0.15
        cell.contentBlock.layer.shadowOffset = CGSize.zero
        cell.contentBlock.layer.shadowRadius = 5
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}
extension ResultViewController: UITableViewDelegate{
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "tryTest", sender: self)
//        
//    }
//    
    
}

