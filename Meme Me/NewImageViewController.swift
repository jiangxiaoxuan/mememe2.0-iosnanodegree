//
// NewImageViewController.swift
//  Meme Me
//
//  Created by JiangXiaoxuan on 18/2/18.
//  Copyright © 2018 JiangXiaoxuan. All rights reserved.
//

import UIKit

class NewImageViewController: UIViewController {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(textField: topTextField)
        configure(textField: bottomTextField)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(dismissCurrentViewController))
    }
    
    @objc func dismissCurrentViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configure(textField: UITextField) {
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3.0,
        ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.clearsOnBeginEditing = true
        textField.backgroundColor = UIColor.clear
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = imagePickerView.image != nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        showImagePicker(sourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        showImagePicker(sourceType: .camera)
    }
    
    private func showImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if topTextField.isFirstResponder {
            view.frame.origin.y = -topTextField.frame.origin.y + 20
        } else if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification) + (view.frame.size.height - (bottomTextField.frame.origin.y + bottomTextField.frame.size.height))
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @IBAction func shareMeme(){
        let generatedMemeImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems:[generatedMemeImage],applicationActivities:nil)
        controller.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed || error == nil {
                self.meme = self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(controller, animated:true, completion: nil)
    }
    
    func save() -> Meme {
        // Create the meme
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        //Add it to the memes array on the Application Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
        return meme
    }

    func generateMemedImage() -> UIImage {
        // Render view to an image
        UIGraphicsBeginImageContext(imagePickerView.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return memedImage
    }
    
}

extension NewImageViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension NewImageViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        imagePickerView.image = nil;
        dismiss(animated: true, completion: nil)
    }
}
