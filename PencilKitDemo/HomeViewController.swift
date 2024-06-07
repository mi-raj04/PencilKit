//
//  HomeViewController.swift
//  SectionIndexInSwiftUIText
//
//  Created by mind on 07/06/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapSaveDrawing(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SavedDrawingListVC") as! SavedDrawingListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onTapNewDrawing(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
