


import UIKit





class WelcomeViewController: UIViewController {
    
    
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hide navigation bar in welcomeVC
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //unhide navigation bar in others VC except weatherVC
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       titleLabel.text = ""
        
        let tittleText = K.appName
        var charIndex = 0.0
        
        for letter in tittleText {
            
            //print("-")
            //print(0.1 * charIndex)
            //print(letter)
            
           Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex , repeats: false) { (Timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
            
        }
        
       
       
        
        
}
    
    
    
    
    
}
