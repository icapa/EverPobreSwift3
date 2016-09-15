//
//  PhotoViewController.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 13/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var model : Note
    
    @IBAction func deletePhoto(_ sender: AnyObject) {
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        // Crear una instancia de UIImagePicker
        let picker = UIImagePickerController()
        
        // Configurarlo
        if UIImagePickerController.isCameraDeviceAvailable(.rear){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        
        picker.delegate = self
        
        // Mostrarlo de forma modal
        self.present(picker, animated: true){
            // Por si quieres hacer algo más nada más mostrarse el picker
            
        }
        
        
    }
    @IBOutlet weak var photoView: UIImageView!
    
    
    init(model: Note){
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

    func syncModelView(){
        title = model.text
        photoView.image = model.photo?.image
        
    }
    
    func syncViewModel(){
        model.photo?.image = photoView.image
    }
    
}

//MARK: - Delegates

extension PhotoViewController:UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Redimensionarla al tamaño de la pantalla
        // deberes (esta en el online)
        
        model.photo?.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        // Quitamos el picker
        self.dismiss(animated: true){
            
        }
    }
}







