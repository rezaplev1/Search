//
//  FilterViewController.swift
//  Search
//
//  Created by reza pahlevi on 9/28/18.
//  Copyright © 2018 tokopedia. All rights reserved.
//

import UIKit

protocol FilterViewDelegate : class {
    func searchFilter(_ filterSearchApi: SearchApi)
}

class FilterViewController: UIViewController {

    weak var delegate: FilterViewDelegate?
    @IBOutlet weak var minPriceLbl: UILabel!
    @IBOutlet weak var maxPriceLbl: UILabel!
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var goldMerchantBtn: UIButton!
    @IBOutlet weak var officialSotreBtn: UIButton!
    
    var searchApi = SearchApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(self.didTapCloseButton))
        priceSlider.addTarget(self, action: #selector(stateChanged),for: .valueChanged)
        priceSlider.minimumValue = 10000
        priceSlider.maximumValue = 10000000
        minPriceLbl.text = String(priceSlider.minimumValue)
        maxPriceLbl.text = String(priceSlider.maximumValue)


        // Do any additional setup after loading the view.
    }
    @objc func didTapCloseButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func stateChanged(sliderState: UISlider) {
        minPriceLbl.text = String(sliderState.minimumValue)
        maxPriceLbl.text = String(sliderState.value)
    }

    @IBAction func isWholeSale(_ sender: UISwitch) {
        if sender.isOn {
            sender.setOn(false, animated:true)
            searchApi.wholesale = false
        } else {
            sender.setOn(true, animated:true)
            searchApi.wholesale = true
        }
    }
    
    @IBAction func goToshopTypeList(_ sender: Any) {
        
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        delegate?.searchFilter(searchApi)
        didTapCloseButton()
    }
    
}
