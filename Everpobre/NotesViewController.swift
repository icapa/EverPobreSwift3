//
//  NotesViewController.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 13/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class NotesViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let fc = fetchedResultsController else {
            return
        }
        title = (fc.fetchedObjects?.first as? Note)?.notebook?.name
        
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt IndexPath: IndexPath) -> UITableViewCell{
        // La ide
        let cellId = "NoteCell"
        
        // la nota
        let note = fetchedResultsController?.object(at: IndexPath) as! Note
        
        // la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sincronizamos
        cell?.imageView?.image = note.photo?.image
        cell?.textLabel?.text = note.text
        
        // La devolvemos
        return cell!
    }
   
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        // Averiguar la nota
        let nt = fetchedResultsController?.object(at: indexPath) as! Note
        
        // Crear el VC de la nota
        
        let vc = NoteViewController(model: nt)
        
        // Mostrarlo
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
