//
//  MoveFolderViewController.swift
//  Harmanpreet_C0765590_Note_P1
//
//  Created by MacStudent on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class MoveFolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var foldersTableView: UITableView!
    
    var delegateAddNotes: AddNotesTableViewController?
    
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
        
        moveAlert(indexPath: indexPath)

    }
    
    func moveAlert(indexPath: IndexPath){
        let alertController = UIAlertController(title: "Move to \(FoldersNotes.folders[indexPath.row].folderName)", message: "Are you sure?", preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (noAction) in
//            self.view.removeFromSuperview()
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        let moveAction = UIAlertAction(title: "Move", style: .default) { (action) in
            self.delegateAddNotes?.moveNotes(folderIndex: indexPath.row)
//            self.view.removeFromSuperview()
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
                
        noAction.setValue(UIColor.orange, forKey: "titleTextColor")
        moveAction.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(noAction)
        alertController.addAction(moveAction)
        
        self.present(alertController, animated: false, completion: nil)
    }

    
    @IBAction func buttonCancel(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
