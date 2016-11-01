//
//  RecipientListViewController.swift
//  Turfy
//
//  Created by James Stonehill on 01/11/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit

class RecipientListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let data:[String] = ["James","Tam","Jimmy"]
    var selectedRecipient: String = "DEFAULT"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected \(data[indexPath.row])")
        selectedRecipient = data[indexPath.row]
        
    
        self.performSegue(withIdentifier: "goToCompose", sender:self)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let composeVC:ComposeViewController = segue.destination as! ComposeViewController
        print("In prepare part \(selectedRecipient)")
        composeVC.recipient = selectedRecipient
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
