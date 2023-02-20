//
//  ByteCoinViewController.swift
//  ByteCoin
//
//  Created by Михаил Позялов on 17.02.2023.
//

import UIKit

class ByteCoinViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ByteCoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
}

//MARK: - CoinManagerDelegate

extension ByteCoinViewController: CoinManagerDelegate {
    func didUpdateRate(price: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price.rateString
            self.currencyLabel.text = price.currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
