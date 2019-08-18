import UIKit
import SDWebImage

private enum Constants {
    static let TitleVc = "News"
    static let IdentifierCell = "ProductCell"
    
}
class SearchResultViewController: UIViewController, CoreApiDelegate {
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    lazy var collectionViewFlowLayout: CustomCollectionViewFlowLayout = {
        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: self.view.bounds.width)
        return layout
    }()
    
    var searchApi = SearchApi()
    var products : [Doc] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.TitleVc
        // Do any additional setup after loading the view.
        self.productCollectionView.collectionViewLayout = self.collectionViewFlowLayout

        productCollectionView.register(UINib(nibName: Constants.IdentifierCell, bundle: nil), forCellWithReuseIdentifier: Constants.IdentifierCell)
        searchApi.delegate = self
        lazyLoadState()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.reloadCollectionViewLayout(self.view.bounds.size.width)
    }
    
    private func reloadCollectionViewLayout(_ width: CGFloat) {
        
        self.collectionViewFlowLayout.containerWidth = width
        self.collectionViewFlowLayout.display = self.view.traitCollection.horizontalSizeClass == .compact && self.view.traitCollection.verticalSizeClass == .regular ? CollectionDisplay.list : CollectionDisplay.grid(columns: 5)
        
    }
    
    private func lazyLoadState() {
        searchApi.page = searchApi.page + 1
        searchApi.start()
    }
    // MARK: - CoreApiDelegate
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        
        do{
            let listProduct = try! JSONDecoder().decode(TimeNews.self, from: data)
            products += listProduct.response?.docs ?? []
            productCollectionView.reloadData()
        }catch{
            print("error")
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
        let a = product.getImageUri()
        let imageUrl = URL(string: (product.getImageUri() ?? ""))
        productCell.image.sd_setImage(with: imageUrl, placeholderImage: nil, options: .highPriority, completed: nil)
        productCell.name.text = product.snippet
        productCell.price.text = product.headline?.main
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
