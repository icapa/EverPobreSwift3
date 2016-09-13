//
//  NoteViewController.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 13/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    var model : Note
    
    @IBAction func displayPhoto(_ sender: AnyObject) {
    }
    
    @IBOutlet weak var textView: UITextView!
    
    init(model: Note){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func syncModelView(){
        textView.text = model.text
        
    }
    
    func syncViewModel(){
        model.text = textView.text
    }
    
    
    //MARK: - Sync
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        syncViewModel()
    }
    
    
}
