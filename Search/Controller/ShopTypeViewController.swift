//
//  ShopTypeViewController.swift
//  Search
//
//  Created by reza pahlevi on 9/29/18.
//  Copyright © 2018 tokopedia. All rights reserved.
//

import UIKit

private enum Constants {
    static let FirstSectionTitle = "Shop Type"
    static let GoldMerchant = "Gold Merchant"
    static let OfficialStore = "Official Store"
}

protocol ShopTypeViewDelegate : class {
    func shopTypeFilter(itemSelected: [String])
}

class ShopTypeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: ShopTypeViewDelegate?
    var itemSelected = [String]()
    var itemsToLoad: [String] = [Constants.GoldMerchant, Constants.OfficialStore]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.FirstSectionTitle
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "tutup", style: .plain, target: self, action: #selector(self.closeAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(self.resetShopTypeAction))

    }

    @IBAction func applyAction(_ sender: UIButton) {
        delegate?.shopTypeFilter(itemSelected: itemSelected)
        closeAction()
    }
    
    
    @objc func closeAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func resetShopTypeAction(){
        itemSelected.removeAll()
        tableView.reloadData()
        
    }
}
// MARK: - UITableViewDataSource
extension ShopTypeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        
        return itemsToLoad.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.accessoryType = .none
        cell.textLabel?.text = self.itemsToLoad[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ShopTypeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
             if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                if let index = itemSelected.index(of: cell.textLabel?.text ?? "") {
                    itemSelected.remove(at: index)
                }
             }else{
                cell.accessoryType = .checkmark
                itemSelected.append(cell.textLabel?.text ?? "")
            }
        }
    }
}
