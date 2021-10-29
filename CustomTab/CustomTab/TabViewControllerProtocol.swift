//
//  TabViewControllerProtocol.swift
//  CustomTab
//
//  Created by HooGi on 2021/10/29.
//

import UIKit

protocol TabViewControllerDelegate {
    /**
     각 탭에 해당하는 뷰컨트롤러 설정
     Set to the `ViewControllers` related `Tab`
     
     - Parameter tabViewController: Own's ViewContoller
     
     - Returns: To set `ViewControllers`
     **/
    func setContentControllers(_ tabViewController: UIViewController) -> [UIViewController]
    
    /**
     각 탭에 해당하는 타이틀 설정
     Set to the `Titles` related `Tab`
     
     - Parameter tabViewController: Own's ViewContoller
     
     - Returns: To set `Titles`
     **/
    func setTabTitles(_ tabViewController: UIViewController) -> [String]
    
}
