//
//  ViewController.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/12.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        searchBar.delegate = self
        
        searchBar.placeholder = "搜尋站點"
        searchBar.searchBarStyle = .minimal
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    

    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    @objc func hambergerTap() {
        performSegue(withIdentifier: "goToSidePage", sender: self)

    }
    @objc func logoPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func xmarkPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSidePage" {
            let destinationVC = segue.destination as! SidePageViewController
            destinationVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkPressed))
            destinationVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ubike"), style: .plain, target: self, action: #selector(logoPressed))
            destinationVC.navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
            destinationVC.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
    }
    
    func navigationBarSetting() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(hambergerTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ubike"), style: .plain, target: self, action: #selector(logoPressed))
        navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension HomeViewController: UISearchBarDelegate{
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        
        searchBar.resignFirstResponder()
    }
    
}

