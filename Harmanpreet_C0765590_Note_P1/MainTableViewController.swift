//
//  MainTableViewController.swift
//  Harmanpreet_C0765590_Note_P1
//
//  Created by MacStudent on 2019-11-08.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    @IBOutlet weak var tabButton: UIBarButtonItem!
    @IBOutlet var tableFolders: UITableView!
//    var folders: [String]?
    @IBOutlet weak var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
//        folders = []
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .darkGray
        
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

 */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return folders?.count ?? 0
        return FoldersNotes.folders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        
        //        let cell = UITableViewCell(style: .value1, reuseIdentifier: "myCell")
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell"){
//            cell.textLabel?.text = folders![indexPath.row]
            
            cell.textLabel?.text = FoldersNotes.folders[indexPath.row].folderName
            cell.imageView?.image = UIImage(named: "ic_folder")
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .darkGray
            cell.detailTextLabel?.text = "\(FoldersNotes.folders[indexPath.row].notes.count)"
            cell.detailTextLabel?.textColor = .white
            
            //cell.selectionStyle
            
            return cell
        }
        return UITableViewCell()
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    //to delete a folder by swiping
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextualAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
//            self.folders!.remove(at: indexPath.row)
            FoldersNotes.folders.remove(at: indexPath.row)
            self.tableFolders.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [contextualAction])
       
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//            let movedItem = folders![fromIndexPath.row]
//            folders!.remove(at: fromIndexPath.row)
//            folders!.insert(movedItem, at: to.row)
        
        let folderToMove = FoldersNotes.folders[fromIndexPath.row].folderName
        let folderNotes = FoldersNotes.folders[fromIndexPath.row].notes
        
        let itemMoved = FoldersNotes(folderName: folderToMove, notes: folderNotes)
        FoldersNotes.folders.remove(at: fromIndexPath.row)
        FoldersNotes.folders.insert(itemMoved, at: to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    

    // MARK: - Navigation

    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? AddNotesTableViewController{
            destination.delegateFolderView = self
            
            if let tableCell = sender as? UITableViewCell{
                if let index = tableView.indexPath(for: tableCell)?.row{
                    destination.curFolderIndex = index
                }
            }
            
        }
    }
 
 
    // To add new folder
    @IBAction func btnNewFolder(_ sender: UIBarButtonItem) {
        
        var alreadyExists = false
        
        let alertController = UIAlertController(title: "New Folder", message: "Enter a name for this folder", preferredStyle: .alert)
        
        alertController.addTextField { (txtNewFolder) in
            txtNewFolder.placeholder = "Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
        
        
        let addItemAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let textField = alertController.textFields![0]
//            self.folders!.append(textField.text!)
            let newFolder = FoldersNotes(folderName: textField.text!, notes: [])
            
            // check if folder name already exists
            for folder in FoldersNotes.folders{
                if textField.text! == folder.folderName{
                    self.showAlert("Name Taken", "Please choose a different name")
                    alreadyExists = true
                }
            }
            
            if !alreadyExists{
                FoldersNotes.folders.append(newFolder)
                self.tableFolders.reloadData()
                alreadyExists = false
            }
            
        }
        addItemAction.setValue(UIColor.black, forKey: "titleTextColor")
        
//        alertController.view.tintColor = .black
        
        alertController.addAction(cancelAction)
        alertController.addAction(addItemAction)
        
//        self.present(alertController, animated: false, completion: {() -> Void in
//            alertController.view.tintColor = .black
//        })
        self.present(alertController, animated: false, completion: nil)
    }
    
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        navTitle.title = "Folders"
//
//    }
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        navTitle.title = ""
//    }
    
    func showAlert(_ title: String, _ msg: String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        okAction.setValue(UIColor.brown, forKey: "titleTextColor")
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
