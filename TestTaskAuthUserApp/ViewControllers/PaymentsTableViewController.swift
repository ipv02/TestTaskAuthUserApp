

import UIKit

class PaymentsTableViewController: UITableViewController {
    
    //MARK: - Properies
    var login: String?
    var token: String?
    var postResponse: PostResponse?
    var payment: Payment?
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = login
            
        tableView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9607843137, alpha: 1)
        tableView.register(UINib(nibName: "PaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "paymentCell")
        tableView.separatorStyle = .none
        
        fetchToken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchPayments()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payment?.response.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTableViewCell
        
        guard let paymentData = payment?.response[indexPath.row] else { return cell }
        cell.configureCell(paymentData: paymentData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: - Private methods
    private func fetchToken() {
        NetworkService.shared.postRequest { (postResponse) in
            self.postResponse = postResponse
            self.token = postResponse.response?.token ?? ""
        }
    }
    
    private func fetchPayments() {
        
        guard let tokenValue = token else { return }
        let parameters = ["token": tokenValue]
        
        NetworkService.shared.getRequest(parameters: parameters) { (payment) in
            self.payment = payment
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    //MARK: - IB Actions
    @IBAction func logOutButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
