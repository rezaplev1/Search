import UIKit
import SDWebImage

private enum Constants {
    static let TitleVc = "Search"
    static let IdentifierCell = "ProductCell"
    static let CloseTitle = "tutup"
    static let ResetTitle = "Reset"
    static let HeightCell : CGFloat = 260
}
class SearchResultViewController: UIViewController, CoreApiDelegate, FilterViewDelegate {
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    var searchApi = SearchApi()
    var products : [DatumElement] = []
    let filtervc = FilterViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.TitleVc
        // Do any additional setup after loading the view.
        productCollectionView.register(UINib(nibName: Constants.IdentifierCell, bundle: nil), forCellWithReuseIdentifier: Constants.IdentifierCell)
        searchApi.delegate = self
        filtervc.delegate = self
        lazyLoadState()
        
    }

    @IBAction func filterAction(_ sender: UIButton) {
        let nav = UINavigationController(rootViewController: filtervc)
        self.present(nav, animated: true, completion: nil)
    }
    
    private func lazyLoadState() {
        searchApi.skip = String(products.count)
        searchApi.start()
    }
    
    // MARK: - FilterViewDelegate
    func searchFilter(maxPrice: String, minPrice: String, isWholeSale: Bool, isOfficial: Bool, fShop: String) {
        searchApi.priceMax = maxPrice
        searchApi.priceMin = minPrice
        searchApi.wholesale = isWholeSale
        searchApi.official = isOfficial
        searchApi.fshop = fShop
        products.removeAll()
        lazyLoadState()
    }
    
    // MARK: - CoreApiDelegate
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        
        do{
            let listProduct = try JSONDecoder().decode(Products.self, from: data)
            products += listProduct.data ?? []
            print(products)
            productCollectionView.reloadData()
        }catch{
        }
    }
    
}

extension SearchResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell : ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.IdentifierCell, for: indexPath) as! ProductCell
        
        let product = self.products[indexPath.row]
        let imageUrl = URL(string: (product.imageURI ?? ""))
        productCell.image.sd_setImage(with: imageUrl, placeholderImage: nil, options: .highPriority, completed: nil)
        productCell.name.text = product.name
        productCell.price.text = product.price
        return productCell
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.products.count - 1 {
            lazyLoadState()
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.productCollectionView.frame.width / 2), height: Constants.HeightCell) // The size of one cell
    }
}
