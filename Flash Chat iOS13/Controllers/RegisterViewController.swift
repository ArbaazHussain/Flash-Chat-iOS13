


import UIKit
import Firebase





class RegisterViewController: UIViewController {
     
    
    
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text{
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            //above line,to create new user using email and password
            
            if let e = error{
                print(e.localizedDescription)
            }else{
               //authentication has been done,navigate to chat view Controller
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
            
        }
            
    }
}
  
    
    
    
    
}
