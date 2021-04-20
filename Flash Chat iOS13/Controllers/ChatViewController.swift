//arbaaz

import UIKit
import Firebase





class ChatViewController: UIViewController {
    
    
   
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    
    
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self//1 STEP-:when tableView loads up, it is going to make a request for data. as, dataSource is set as self VC. so it will triger the UITableViewDataSource delegate method to get data.
        
        title = K.appName//adds tittle inside navigation bar inside chatVC.
        
        navigationItem.hidesBackButton = true//Hides the back button in chatVC.
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)//The First step of using custom design file,is to register it in viewdid load.
        
        loadMessages()
        
        
        
        
        
}
    
    
    
    
    
//MARK: - Read Data From FireStore
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                //addSnapshotListener listen for changes in db ,then its goona trigger all the code inside this closure
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        
                        let data = doc.data()
                        
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            
                            DispatchQueue.main.async {
                                
                                //calls UITableViewDataSource delegate and put cells to table view
                                   self.tableView.reloadData()
                                
                                //set value in index path of bottom row.
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                
                                //to scroll to very bottom on table view
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                
                                
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
        
}
    
    
    
    
    
 //MARK: - Add Data To FireStore
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        //to clear text field, when message is send
                         self.messageTextfield.text = ""
                    }
                }
            }
        }
        
        
        
        
        
}
    
    
    
    
    
    //MARK: - Logout
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)//when logout button is pressed, then it moves to rootViewController
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
}
    
    
    
    
    
}





//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    
    
    
    //to define number of row or cells in table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return messages.count
    }
    
    
    
    
    
    //This method is called for as many rows or cell as we have in tableView.
    //And each time it is asking for a cell for particular row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //[indexPath.row] = current number of message in <messages array>
        let message = messages[indexPath.row]
        
        
        //< as! MessageCell> is used, in order to know all those properties in MessageCell class
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        
        cell.label.text = message.body
        
        
        //Check if message is from sender.
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            
            //K.BrandColors.lightPurple = "BrandLightPurple"
            //"BrandLightPurple" is custom color inside assets
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        
        
        //check if message is from another sender.
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
      
      
        return cell
    }
    
    
    
    
    
}


