//
//  PhotoViewController.swift
//  Everpobre
//
//  Created by Iván Cayón Palacio on 13/9/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit
import CoreImage


class PhotoViewController: UIViewController {

    var model : Note
    
    @IBAction func applyFilter(_ sender: AnyObject) {
        guard let image = photoView.image else{
            return
        }
        
       
        
        // CIImage, Context, CIFilter
        
        // Imagen de entrada
        let img = CIImage(image: image)
        
        // Contexto: el que crea la imagen final
        let ctxt = CIContext(options: nil)
        
        // Filtro (usado por el contexto)
        let vintage = CIFilter(name:"CIFalseColor")
        vintage?.setDefaults()
        vintage?.setValue(img, forKey: "inputImage")
        
        // La imagen final
        let finaImg = vintage?.value(forKey: kCIOutputImageKey) as! CIImage
        
        // Aquí es donde se aplica el filtro y que consume tiempo
        // Cuello de botella
        
        let res = ctxt.createCGImage(finaImg, from: finaImg.extent)
        
        let viewImage = UIImage(cgImage: res!)
        photoView.image = viewImage
      
    }
    
    
    @IBAction func deletePhoto(_ sender: AnyObject) {
       
        let oldBounds = self.photoView.bounds
        
        // Animacion
        UIView.animate(withDuration: 0.9,
                       animations: {
                        self.photoView.alpha = 0
                        self.photoView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
                        self.photoView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
             }){(finished: Bool) in
                self.photoView.bounds = oldBounds
                self.photoView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                self.photoView.alpha = 1
                self.model.photo?.image=nil
                self.syncModelView()

        }
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







