//
//  MoveFolderViewController.swift
//  Harmanpreet_C0765590_Note_P1
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class MoveFolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegateAddNotes: AddNotesTableViewController?
    
    @IBOutlet weak var foldersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        foldersTableView.backgroundColor = .darkGray
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FoldersNotes.folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "moveFolderCell"){
            cell.textLabel?.text = FoldersNotes.folders[indexPath.row].folderName
            cell.backgroundColor = .darkGray
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let alertController = UIAlertController(title: "Move to \(FoldersNotes.folders[indexPath.row].folderName)", message: "Are you sure?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .cancel)
        let moveAction = UIAlertAction(title: "Move", style: .default) { (action) in
            
        }
        
        alertController.addAction(noAction)
        alertController.addAction(moveAction)
        
        self.present(alertController, animated: false, completion: nil)
        
        delegateAddNotes?.moveNotes(folderIndex: indexPath.row)
        
        
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
