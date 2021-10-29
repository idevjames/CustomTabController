//
//  TabViewController.swift
//  CustomTab
//
//  Created by HooGi on 2021/10/29.
//

import UIKit

enum CellType: String {
    case mainTab = "MainTabCell"
}

class TabViewController: UIViewController {
    
    // MARK: - UI Components
    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    
    // MARK: - Properties
    public var delegate: TabViewControllerDelegate?
    
    private var viewControllers: [UIViewController]?
    private var tabTitles: [String]?
    private var tabCellType: CellType = .mainTab
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewControllers = delegate?.setContentControllers(self)
        tabTitles = delegate?.setTabTitles(self)
        
        setupCollectionView()
        
        let firstViewController = viewControllers?.first
        change(asChildViewController: firstViewController)
    }

    // MARK: - Setup UI
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        tabCollectionView.showsHorizontalScrollIndicator = false
        
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        tabCollectionView.collectionViewLayout = layout
        tabCollectionView.register(UINib(nibName: tabCellType.rawValue, bundle: nil), forCellWithReuseIdentifier: tabCellType.rawValue)
    }
    
    private func change(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }

        if children.isEmpty {
            add(asChildViewController: viewController)
        } else {
            if let lastViewController = children.last {
                if lastViewController == viewController { return }
                else {
                    remove(asChildViewController: lastViewController)
                    add(asChildViewController: viewController)
                }
            }
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        contentView.addSubview(viewController.view)
        
        viewController.view.frame = contentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func move(asChildViewController viewController: UIViewController) {
        viewController.didMove(toParent: self)
    }
}


//
// MARK: - UICollectionView Delegate, Datasource, FlowLayoutDelegate
//
extension TabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch tabCellType {
        case .mainTab:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCellType.rawValue, for: indexPath) as! MainTabCell
            cell.configure(title: tabTitles?[indexPath.item])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        change(asChildViewController: viewControllers?[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = tabTitles?[indexPath.item] ?? ""
        let itemSize = item.size(withAttributes: [.font : UIFont.systemFont(ofSize: 17)])
        
        return CGSize(width: itemSize.width+30, height: 70)
    }
}
