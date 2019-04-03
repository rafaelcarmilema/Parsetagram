//
//  CameraViewController.swift
//  Parsetagram
//
//  Created by Rafael Carmilema on 3/24/19.
//  Copyright © 2019 Rafael Carmilema. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }
            else{
                self.dismiss(animated: true, completion: nil)
                print("error!")
            }
            
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera  // if cam avaiable then use that one
        }
        else{
            picker.sourceType = .photoLibrary // opens library if no cam available
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    //after image is selected this will take care of image selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        // resize image
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
