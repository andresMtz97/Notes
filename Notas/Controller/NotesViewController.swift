//
//  NotesViewController.swift
//  Notas
//
//  Created by Rafael González on 19/04/24.
//

import UIKit

class NotesViewController: UITableViewController {
    
    @IBOutlet var emptyNotesView: UIView!
    @IBOutlet var noteList: UITableView!
    var notesManager = NotesManager()
    var note : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesManager.loadNotes()
        if notesManager.countNotes() == 0 {
            emptyNotesView.isHidden = false
            noteList.backgroundView = emptyNotesView
        }
        else {
            emptyNotesView.isHidden = true
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesManager.countNotes()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoteCell
        cell?.noteTitle.text = notesManager.getNote(at: indexPath.row).title
        cell?.noteDate.text = notesManager.getNote(at: indexPath.row).date.iso8601String
        return cell!
    }
    
    //Unwind segue
    @IBAction func unwindToNotesViewController(_ segue : UIStoryboardSegue){
        //print("Unwind Segue!")
        let source = segue.source as! AddNoteViewController
        note = source.newNote
        notesManager.createNote(note: note!)
        print("#N: ", notesManager.countNotes())
        notesManager.saveNotes()
        //reload table view
        noteList.reloadData()
    }
    

   
}
