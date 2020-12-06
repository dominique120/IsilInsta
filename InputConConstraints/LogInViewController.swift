//
//  LogInViewController.swift
//  InputConConstraints
//
//  Created by Dominique Verellen on 10/11/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    var arrayPersons = [Person]()
    /* LogIn Actions */
    @IBAction func clickCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    /* LogIn Outlets */
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtPssword: UITextField!
    @IBOutlet weak var mainBox: UIView!
    
    override func viewDidLoad() {
        self.setNeedsStatusBarAppearanceUpdate()
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func getPersonInfo() {
        
        //print(UserBE.shared?.personId)
        guard let personId = UserBE.shared?.personId else { return }
        
        PersonWS.getPersonByUserId(personId, success: { (objPerson) in
            PersonBE.shared = objPerson
            self.setProfileInformation(objPerson)
            
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    func setProfileInformation(_ objPerson: PersonBE) {
        //TODO: Asignar los valores de la persona en la UI
        
        //self.lblEmail.text = objProfile.email
    }
    
    
    @IBAction func onSignIn(_ sender: Any) {
        let usr: String = txtFirstName.text!
        let pwd: String = txtPssword.text!        
         
        AuthWS.doLogin(password: pwd, username: usr, success: { (_) in
            self.getPersonInfo()
            self.performSegue(withIdentifier: "TabBarApplication", sender: nil)
            
        }) { (errorMessage) in
            Util.showMessage(controller: self, message: "Credenciales Incorrectas", seconds: 5.0)
            print(errorMessage)
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        view.frame.origin.y = -keyboardFrame.size.height + 220
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
}


