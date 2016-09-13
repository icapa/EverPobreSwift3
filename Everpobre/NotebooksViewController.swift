//
//  NotebooksViewController.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 12/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit
import CoreData

class NotebooksViewController: CoreDataTableViewController {

    
   
}

//MARK: - DataSource
extension NotebooksViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Everpobre"
        
        addNewNotebookButton()
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        
        let cellId = "NotebookCell"
        
        // Averiguar la libreta
        
        
        
        let nb = fetchedResultsController?.object(at: indexPath) as! Notebook
        
        
        
        // Crear la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        //Configurarla
        
        cell?.textLabel?.text = nb.name ?? "New Notebook"
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        cell?.detailTextLabel?.text = fmt.string(from: nb.modificationDate as! Date)
        
        
        //Devolvera
        return cell!
    }
    
    //MARK: - Utils
    func  addNewNotebookButton(){
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNotebook))
        navigationItem.rightBarButtonItem = btn
    }
    
    //MARK: - Actions
    func addNewNotebook(){
        // Crear una nueva libreta
        guard let fc = fetchedResultsController else{
            return
        }
        
        let _ = Notebook(name: "Nueva libreta", inContext: fc.managedObjectContext)
        
    }
    
    //MARK: - Delegate
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        // Averiguar la libreta
        let nb = fetchedResultsController?.object(at: indexPath) as! Notebook
        
        // Crear el fetch
        let req = NSFetchRequest<Note>(entityName: Note.entityName)
        req.fetchBatchSize = 50
        req.predicate = NSPredicate(format: "notebook == %@", nb)
        req.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: false)]
        
        // El fetchedResultsController
        let fc = NSFetchedResultsController(fetchRequest: req,
                                            managedObjectContext: nb.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        // Crea el controlador
        
        let notesVC = NotesViewController(fetchedResultsController: fc as! NSFetchedResultsController<NSFetchRequestResult>)
        
        // Mostrarlo
        navigationController?.pushViewController(notesVC, animated: true)
        
    }
}
