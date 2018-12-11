//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Dinsaren on 12/8/18.
//  Copyright © 2018 Dinsaren. All rights reserved.
//

import UIKit
import CoreData
class AddNoteViewController: UIViewController {
    @IBOutlet weak var titleNotesTextField: UITextField!
    @IBOutlet weak var descriptionNotesTextView: UITextView!
    var notestitle: String?
    var notesdes: String?
    var id:String?
    var arrayNotesList = [Notes]()
    let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil))
    override func viewDidLoad() {
        super.viewDidLoad()
        if notestitle == nil {
            titleNotesTextField.placeholder="Notes"
        }else{
            titleNotesTextField.text = notestitle
            descriptionNotesTextView.text = notesdes
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        fetch()
    }
    override func viewDidDisappear(_ animated: Bool) {
        if notestitle == nil{
             saveData(notesName: titleNotesTextField.text!, notesDescription: descriptionNotesTextView.text!)
        }else{
            update(id: id!, newTitle:  titleNotesTextField.text!, newDes:descriptionNotesTextView.text! )
        }
       
    }
    func saveData(notesName:String,notesDescription:String) {
        let context = AppDelegate.persistentContainer.viewContext
        let notesEnity = Notes(context:context)
        let autoid = arrayNotesList.count + 1
        notesEnity.notesId = "\(uuid!)\(autoid)"
        notesEnity.notesName = titleNotesTextField.text
        notesEnity.notesDescription = descriptionNotesTextView.text
        do {
            try context.save()
            print("SUCCESS")
        }catch let error{
            print("ERROR INSERT" + error.localizedDescription)
        }
        
    }
    func update(id: String?, newTitle: String, newDes: String) {
        let context = AppDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        let recentNotes = try? context.fetch(request)
        if let notes = recentNotes {
            for note in notes where note.notesId!.contains(id!){
              note.notesName=newTitle
              note.notesDescription=newDes
            }
        }
        try? context.save()
        
    }
    func fetch() {
        let context = AppDelegate.viewContex
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        arrayNotesList = try! context.fetch(request)
        if  !arrayNotesList.isEmpty {
            for note in arrayNotesList{
                print("UUID : \(note.notesId!)")
                print("Title : \(note.notesName!)")
                print("Description : \(note.notesDescription!)")
            }
        }
    }
}
