//
//  AppDelegate.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 6/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let model = CoreDataStack(modelName: "Model")!
    
    
    func loadDummyData(){
        // Borrón y cuenta nueva
        do{
            try model.dropAllData()
        }catch{
            print("La cagamos al borrar")
        }
        
        // Un par de libretas
        let pelis = Notebook(name: "Pelis de los 80", inContext: model.context)
        let wwdc = Notebook(name:"Sesiones WWDC", inContext:model.context)
        
        // Unas notas
        let axel = Note(notebook: pelis, inContext: model.context)
        axel.text="Berverly Hill's Cop"
        let strike = Note(notebook: pelis, inContext: model.context)
        strike.text="The Empire Strikes Back"
        
        let async = Note(notebook: wwdc, inContext: model.context)
        async.text="Asynchronous Development Patterns"

        // Guardamos
        model.save()
        
        
    }
    
    
    func trastearConDatos(){
        // Un par de libretas
        let nb = Notebook(name:"Watchlist",inContext: model.context)
        let wwdc = Notebook(name: "Sesiones WWDC", inContext: model.context)
        
        
        print(wwdc)
        
        // Un par de notas
        let img = UIImage(imageLiteralResourceName: "aperturaDistroLinux.jpg")
        
        let suecas = Note(notebook: nb,
                          image: img,
                          inContext: model.context)
        
        suecas.text = "Tres suecas para 3 Rodriguez"
        
        let expense = Note(notebook: nb, inContext: model.context)
        expense.text = "Serie en Syfy"
        
        let r1 = Note(notebook: nb, inContext: model.context)
        r1.text = "Rogue 1: A Starwars Story"
        
        // Búsqueda
        let req = NSFetchRequest<Notebook>(entityName: Notebook.entityName)
        
        
        req.fetchBatchSize = 50
        
        let notebooks = try! model.context.fetch(req)
        print(type(of: notebooks))
        print(notebooks)
        
        // Filtrado y ordenadado
        let reqn = NSFetchRequest<Note>(entityName: Note.entityName)
        reqn.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: false)]
        
        reqn.predicate = NSPredicate(format: "notebook == %@", nb)
        
        let movies = try! model.context.fetch(reqn)
        
        print(movies)
        // Borrar objetos
        model.context.delete(suecas)
        
        
        // Guardamos
        model.save()
        
        
    }

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Creamos datos chorras
        loadDummyData()
        
        // Creamos el fetchRequest
        let fr = NSFetchRequest<Notebook>(entityName: Notebook.entityName)
        fr.fetchBatchSize = 50
        fr.sortDescriptors = [NSSortDescriptor(key: "name",
                              ascending: false),
            NSSortDescriptor(key: "modificationDate", ascending: true) ]
        // Creamos el fetchedResultsCtrl
        
        let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: model.context, sectionNameKeyPath: nil, cacheName:  nil)
        // Creamos el rootVC
        let nVC = NotebooksViewController(fetchedResultsController: fc as! NSFetchedResultsController<NSFetchRequestResult>, style: .plain)
        
        // Creamos el navegador
        let navVC = UINavigationController(rootViewController: nVC)
        
        
        // Creamos la window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        
        // Lo encasquetamos el rootVC a la window y mostramos
        

        
        //loadDummyData()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

