//
//  AddNotesTableViewController.swift
//  Harmanpreet_C0765590_Note_P1
//
//  Created by MacStudent on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class AddNotesTableViewController: UITableViewController {

    
    @IBOutlet var notesTableView: UITableView!
    @IBOutlet weak var btnMove: UIBarButtonItem!
    @IBOutlet weak var btnDelete: UIBarButtonItem!
    
    var curFolderIndex: Int?
    var curNotesIndex = -1
    var isToggled = false
    var selectedIndex = [Int]()
    var delegateFolderView: MainTableViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = .darkGray
        
        self.tableView.allowsMultipleSelection = true
        //        self.tableView.allowsMultipleSelectionDuringEditing = true

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
//        var a  = FoldersNotes.folders
        return FoldersNotes.folders[curFolderIndex!].notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...

        if let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell"){
            
            cell.textLabel?.text = FoldersNotes.folders[curFolderIndex!].notes[indexPath.row]
            cell.accessoryType = .detailButton
            cell.backgroundColor = .darkGray
            
            return cell
        }
        return UITableViewCell()
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
           selectedIndex.append(indexPath.row)
//           print("selected...\(selectedIndex)")
           
       }
       
       override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           tableView.cellForRow(at: indexPath)?.accessoryType = .detailButton
           
           for index in selectedIndex.indices{
               if selectedIndex[index] == indexPath.row{
                   selectedIndex.remove(at: index)
                   break
               }
           }
      
//           print("Deselected...\(selectedIndex)")
       }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let addNoteDest = segue.destination as? AddNewNote{
            addNoteDest.delegateAddNotesTable = self
            addNoteDest.segue = segue.identifier
            
            if let tableCell = sender as? UITableViewCell{
                if let index = tableView.indexPath(for: tableCell)?.row{
                    
                    addNoteDest.text = FoldersNotes.folders[curFolderIndex!].notes[index]
                    curNotesIndex = index
                }
            }

        }
        else if let moveFolderDest = segue.destination as? MoveFolderViewController{
            moveFolderDest.delegateAddNotes = self
        }
        
    }
    
    
    func addNewNote(note: String){
        FoldersNotes.folders[curFolderIndex!].notes.append(note)
        notesTableView.reloadData()
        print(FoldersNotes.folders[curFolderIndex!].notes)
    }

    func updateItem(item: String){
        
        FoldersNotes.folders[curFolderIndex!].notes[curNotesIndex] = item
                
        let index = IndexPath(item: curNotesIndex, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegateFolderView?.tableFolders.reloadData()
    }

    @IBAction func toggleButton(_ sender: UIBarButtonItem) {
        
        if !isToggled{
            btnDelete.isEnabled = true
            btnMove.isEnabled = true
            isToggled = true
        } else{
            btnDelete.isEnabled = false
            btnMove.isEnabled = false
            isToggled = false
        }
        
    }
    
    
    @IBAction func buttonDelete(_ sender: UIBarButtonItem) {
        
        guard !selectedIndex.isEmpty else {
            return
        }
        
        showDeleteAlert()
        
    }
    
    func showDeleteAlert(){
        
        let alertController = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (deleteAction) in
            self.deleteNotes()
        }
        
        cancelAction.setValue(UIColor.orange, forKey: "titleTextColor")
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func deleteNotes(){
        
        selectedIndex.sort(by: >)
        for items in selectedIndex{
            FoldersNotes.folders[curFolderIndex!].notes.remove(at: items)
        }
        
        tableView.reloadData()
    }
    
    
    func moveNotes(folderIndex: Int){
        
        for index in selectedIndex{
            let note = FoldersNotes.folders[curFolderIndex!].notes[index]
            FoldersNotes.folders[folderIndex].notes.append(note)
        }
        
        // delete notes from current folder after moving to another
        deleteNotes()
           
    }
    
    @IBAction func buttonMove(_ sender: UIBarButtonItem) {
        guard !selectedIndex.isEmpty else {
            return
        }
        
        
        
//        selectedIndex.sort(by: >)
//
//        for items in selectedIndex{
//            FoldersNotes.folders[curFolderIndex!].notes.remove(at: items)
//        }
        
    }
    
}
