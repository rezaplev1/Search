//
//  FilterViewController.swift
//  Search
//
//  Created by reza pahlevi on 9/28/18.
//  Copyright © 2018 tokopedia. All rights reserved.
//

import UIKit

private enum Constants {
    static let TitleVc = "Filter"
    static let CloseTitle = "tutup"
    static let ResetTitle = "Reset"
}

protocol FilterViewDelegate : class {
    func searchFilter(maxPrice: String, minPrice: String, isWholeSale: Bool, isOfficial: Bool, fShop: String)
}

class FilterViewController: UIViewController, ShopTypeViewDelegate {
   
    weak var delegate: FilterViewDelegate?
    @IBOutlet weak var minPriceLbl: UILabel!
    @IBOutlet weak var maxPriceLbl: UILabel!
    
    @IBOutlet weak var maxPriceSlider: UISlider!
    @IBOutlet weak var minPriceSlider: UISlider!
    @IBOutlet weak var goldMerchantBtn: UIButton!
    @IBOutlet weak var officialSotreBtn: UIButton!
    @IBOutlet weak var wholeSaleSwitch: UISwitch!
    
    var isWholeSale = false
    var isOfficial = false
    var fShop = ""
    let shopTypevc = ShopTypeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.TitleVc
        
        shopTypevc.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.CloseTitle, style: .plain, target: self, action: #selector(self.closeAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.ResetTitle, style: .plain, target: self, action: #selector(self.resetFilterAction))
        setupView()
    }
    
    private func setupView(){
        goldMerchantBtn.addTarget(self, action: #selector(goldMerchantAction), for: .touchUpInside)
        officialSotreBtn.addTarget(self, action: #selector(officialSotreAction), for: .touchUpInside)
        wholeSaleSwitch.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
        minPriceSlider.addTarget(self, action: #selector(minPriceSliderAction),for: .valueChanged)
        minPriceSlider.minimumValue = Constant.MinimumValue
        minPriceSlider.maximumValue = Constant.MaximumValue
        minPriceSlider.value = Constant.MinimumValue
        minPriceLbl.text = String(minPriceSlider.minimumValue).toIDR()
        
        maxPriceSlider.addTarget(self, action: #selector(maxPriceSliderAction),for: .valueChanged)
        maxPriceSlider.minimumValue = Constant.MinimumValue
        maxPriceSlider.maximumValue = Constant.MaximumValue
        maxPriceSlider.value = Constant.MaximumValue
        maxPriceLbl.text = String(maxPriceSlider.maximumValue).toIDR()
        isWholeSale = false
        resetShopType()
        
    }
    
    func shopTypeFilter(itemSelected: [String]) {
        resetShopType()
        for item in itemSelected {
            if officialSotreBtn.currentTitle?.contains(item) ?? false{
                officialSotreBtn.backgroundColor = .green
                officialSotreBtn.tintColor = .white
                isOfficial = true
            }
            if goldMerchantBtn.currentTitle?.contains(item) ?? false{
                goldMerchantBtn.backgroundColor = .green
                goldMerchantBtn.tintColor = .white
                fShop = "2"
            }
            
        }
    }

    private func resetShopType(){
        isOfficial = false
        fShop = ""
        officialSotreBtn.backgroundColor = .gray
        officialSotreBtn.tintColor = .white
        goldMerchantBtn.backgroundColor = .gray
        goldMerchantBtn.tintColor = .white
    }
    
    @objc func goldMerchantAction(sender: UIButton) {
        goldMerchantBtn.backgroundColor = .gray
        goldMerchantBtn.tintColor = .white
        fShop = ""
    }
    
    @objc func officialSotreAction(sender: UIButton) {
        isOfficial = false
        officialSotreBtn.backgroundColor = .gray
        officialSotreBtn.tintColor = .white
    }
    
    @objc func closeAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func resetFilterAction(){
        minPriceSlider.value = Constant.MinimumValue
        minPriceLbl.text = String(minPriceSlider.minimumValue).toIDR()
        maxPriceSlider.value = Constant.MaximumValue
        maxPriceLbl.text = String(maxPriceSlider.maximumValue).toIDR()
        wholeSaleSwitch.setOn(false, animated: true)
        
    }
    
    @objc func minPriceSliderAction(sliderState: UISlider) {
        minPriceLbl.text = String(sliderState.value).toIDR()
    }
    
    @objc func maxPriceSliderAction(sliderState: UISlider) {
        maxPriceLbl.text = String(sliderState.value).toIDR()
    }

    @objc func stateChanged(_ sender: UISwitch) {
        if sender.isOn {
            sender.setOn(false, animated:true)
            isWholeSale = false
        } else {
            sender.setOn(true, animated:true)
            isWholeSale = true
        }
    }

    
    @IBAction func goToshopTypeList(_ sender: UIButton) {
        let nav = UINavigationController(rootViewController: shopTypevc)
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        delegate?.searchFilter(maxPrice: String(maxPriceSlider.value), minPrice: String(minPriceSlider.value), isWholeSale: isWholeSale, isOfficial: isOfficial, fShop: fShop)
        closeAction()
    }
    
}
