

import UIKit

class PaymentTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet weak var viewPaymentCell: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
   //MARK: - Date Formatter
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "dd-MM-yyy HH:mm"
        return df
    }()
    
    //MARK: - Life cicle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewPaymentCell.layer.cornerRadius = 10
        viewPaymentCell.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    //MARK: - Configure Cell
    func configureCell(paymentData: PaymentData) {
        
        let date = Date(timeIntervalSince1970: paymentData.created)
        let dateTitle = dateFormatter.string(from: date)
        
        descLabel.text = "Desc: \(paymentData.desc)"
        amountLabel.text = "Amount: \(paymentData.amount)"
        currencyLabel.text = "Currency: \(paymentData.currency ?? "No value")"
        createdLabel.text = "Created: \(dateTitle)"
    }
    
}
