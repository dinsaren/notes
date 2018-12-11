//
//  ViewController.swift
//  Notes
//
//  Created by Dinsaren on 12/7/18.
//  Copyright © 2018 Dinsaren. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var notesCollectionView: UICollectionView!
    var arrayNotesList = [Notes]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetch()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetch()
        notesCollectionView.reloadData()
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
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNotesList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customeCollectionViewCell", for: indexPath) as! CustomeCollectionViewCell
        cell.noteTitleLabel.text = arrayNotesList[indexPath.row].notesName
        cell.noteDesTextView.text = arrayNotesList[indexPath.row].notesDescription
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewUpdate = storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        viewUpdate.notestitle = arrayNotesList[indexPath.row].notesName
        viewUpdate.notesdes = arrayNotesList[indexPath.row].notesDescription
        viewUpdate.id = arrayNotesList[indexPath.row].notesId
        show(viewUpdate, sender: nil)
        
    }
    
    
}
