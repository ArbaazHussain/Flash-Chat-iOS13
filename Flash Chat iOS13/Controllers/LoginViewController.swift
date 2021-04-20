


import UIKit
import Firebase





class LoginViewController: UIViewController {

    
    
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                //above line, to take emailId and password , and check this credentials against what we have stored in firebase Authentication
                
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    //authentication has been done,navigate to chat view Controller
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    print("login in \(email)")
                }
              
            }
            
        }
        
}
    
    
  
    
    
    
}
