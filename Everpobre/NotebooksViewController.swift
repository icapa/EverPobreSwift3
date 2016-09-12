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
}
