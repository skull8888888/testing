//
//  ViewController.swift
//  ENT
//
//  Created by Dinmukhammed on 14.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    
    let menu = ["История Казахстана ЕНТ", "Пройти тест", "Игра на запоминание",
                "Поиск по базе","Закладки"]
    let desc = ["Сменить категорию",
                "Тест из 25 случайно отобранных вопросов из базы",
                "Вопрос и ответ в карточках",
                "Поиск по ключевому слову и ответам",
                "Сохраненные попросы и карточки"]
                
    let icons = [#imageLiteral(resourceName: "open-book"),#imageLiteral(resourceName: "list"),#imageLiteral(resourceName: "network"),#imageLiteral(resourceName: "search"), #imageLiteral(resourceName: "star")]
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "canvasBack"))
        self.view.addBackground()
       // self.setNeedsStatusBarAppearanceUpdate()
    }
    
//    override var prefersStatusBarHidden: Bool{
//        return true
//    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        //let task = menu[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BetaCell
        cell.nameLabel.text = menu[indexPath.row]
        cell.descLabel.text = desc[indexPath.row]
        cell.imageLabel.image = icons[indexPath.row]
       // cell.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        
        let selectedCellColor = UIView()
        selectedCellColor.backgroundColor = .clear
        cell.selectedBackgroundView = selectedCellColor
        tableView.separatorStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
extension ViewController: UITableViewDelegate{
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // DispatchQueue.main.async {
           self.performSegue(withIdentifier: "tryTest", sender: nil)
        //}
        
    }
    
    
}
