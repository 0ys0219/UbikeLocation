//
//  ViewController.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/12.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var hamberger: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var locationInfoPage: UIView!
    @IBOutlet weak var loginPage: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        locationInfoPage.isHidden = false
        loginPage.isHidden = true
        horizontalLine()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hambergerTap))
        hamberger.isUserInteractionEnabled = true
        hamberger.addGestureRecognizer(tap)

    }
    
    func horizontalLine() {
        let line = UIView()
        view.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: view.bounds.width ).isActive = true
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        line.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant: 20).isActive = true
        line.backgroundColor = .secondarySystemBackground
    }
    
    
    @objc func hambergerTap() {
        
        if locationInfoPage.isHidden {
            locationInfoPage.isHidden = false
            loginPage.isHidden = true
            hamberger.image = UIImage(systemName: "line.3.horizontal")
        } else {
            locationInfoPage.isHidden = true
            loginPage.isHidden = false
            hamberger.image = UIImage(systemName: "xmark")
        }
    }
    
    
}


