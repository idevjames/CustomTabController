//
//  ViewController.swift
//  CustomTab
//
//  Created by HooGi on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tab = TabViewController()
        tab.delegate = self
        
        self.addChild(tab)
        mainView.addSubview(tab.view)

        tab.view.frame = mainView.bounds
        tab.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        tab.didMove(toParent: self)
    }
}

extension ViewController: TabViewControllerDelegate {
    func setContentControllers(_ tabViewController: UIViewController) -> [UIViewController] {
        let colors: [UIColor] = [.brown, .red, .cyan, .systemPink, .blue, .green]
        let viewControllers = colors.map { color -> UIViewController in
            let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }
        
        return viewControllers
    }
    
    func setTabTitles(_ tabViewController: UIViewController) -> [String] {
        return ["홈", "휴대형", "절충형", "디럭스형", "쌍둥이형", "웨건"]
    }
    
}
