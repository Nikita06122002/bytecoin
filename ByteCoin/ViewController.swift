//
//  ViewController.swift
//  ByteCoin
//
//  Created by macbook on 23.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel(text: "BitCoin", font: .boldSystemFont(ofSize: 60))
    private let costLabel = UILabel(text: "76938.93", font: .systemFont(ofSize: 25))
    private let money = UILabel(text: "USD", font: .systemFont(ofSize: 20))
    
    private let costView = UIView(color: .systemGray4, radius: 50)
    private let bitcoin = UIImageView(image: UIImage(named: "bitcoin")!)
    private let pickerView = UIPickerView()
    
    private var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Ora")
        view.alpha = 0.8
        setupUI()
        setupConst()
        pickerView.dataSource = self
        pickerView.delegate = self
        coinManager.delegate = self
        
    }
    
    private func configure() {
        
    }
    
    private func setupUI() {
        view.addSubViews(label, costView, pickerView)
        costView.addSubViews(bitcoin, costLabel, money)
        

    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            costView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            costView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            costView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            costView.heightAnchor.constraint(equalToConstant: 100),
            
            bitcoin.heightAnchor.constraint(equalToConstant: 100),
            bitcoin.widthAnchor.constraint(equalToConstant: 100),
            bitcoin.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            bitcoin.leadingAnchor.constraint(greaterThanOrEqualTo: costView.leadingAnchor),

            bitcoin.leadingAnchor.constraint(equalTo: costView.leadingAnchor, constant: 5),
            
            costLabel.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            costLabel.leadingAnchor.constraint(equalTo: bitcoin.trailingAnchor, constant: 10),
            
            money.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            money.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 5),
            money.trailingAnchor.constraint(lessThanOrEqualTo: costView.trailingAnchor),
            
            pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
            
            
        ])
    }


}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRow = coinManager.currencyArray[row]
        coinManager.fetchCoin(for: selectedRow)
        money.text = selectedRow
    }
    
}

extension ViewController: CoinDelegate {
    func didUpdateCoin(coinManager: CoinManager, coin: CoinData) {
        DispatchQueue.main.async {
            self.costLabel.text = String(format: "%.3f", coin.rate)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}


//MARK: - SwiftUI
import SwiftUI
struct Provider_ViewController : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return ViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = ViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) -> ViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: Provider_ViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) {
            
        }
    }
    
}
