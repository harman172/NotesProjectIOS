//
//  AddNewNote.swift
//  Harmanpreet_C0765590_Note_P1
//
//  Created by MacStudent on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class AddNewNote: UIViewController {

    var delegateAddNotesTable: AddNotesTableViewController?
    var segue: String?
    var text: String?
    
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .darkGray
        notesTextView.text = text ?? ""
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if segue == "cellSegue"{
            delegateAddNotesTable?.updateItem(item: notesTextView.text)
        } else if segue == "addNoteSegue"{
            delegateAddNotesTable?.addNewNote(note: notesTextView.text)
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
