

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Properies
    //var postResponse: PostResponse?
    private var user = User.getUserData()
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self

        setupUITextFields()
        setupUILoginButton()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let navVC = segue.destination as! UINavigationController
            let paymentsTableVC = navVC.topViewController as! PaymentsTableViewController
            //paymentsTableVC.postResponse = postResponse
            paymentsTableVC.login = loginTextField.text
            
        }
    }
    
    //MARK: - Setup UI Textfields & Login button
    private func setupUITextFields() {
        loginTextField.layer.cornerRadius = 10
        loginTextField.layer.shadowColor = UIColor.black.cgColor
        loginTextField.layer.shadowRadius = 4
        loginTextField.layer.shadowOpacity = 0.2
        loginTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.shadowColor = UIColor.black.cgColor
        passwordTextField.layer.shadowRadius = 4
        passwordTextField.layer.shadowOpacity = 0.2
        passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func setupUILoginButton() {
        loginButton.layer.cornerRadius = 10
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowRadius = 4
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    //MARK: - IB Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
                
        if loginTextField.text == user.login && passwordTextField.text == user.password {
//            NetworkService.shared.postRequest { (postResponse) in
//                self.postResponse = postResponse
//            }
            performSegue(withIdentifier: "details", sender: nil)
        } else {
            showAlert(title: "Invalid login or password", message: "Please, enter correct login and password")
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        loginTextField.text = nil
        passwordTextField.text = nil
    }
}
