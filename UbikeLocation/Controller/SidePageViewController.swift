//
//  LoginPageViewController.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/12.
//

import UIKit

class SidePageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginButton: UIButton!
    let options = ["使用說明","收費方式","站點資訊","最新消息","活動專區"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AccentColor")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableViewSetting()
        
        loginButtonSetting()
        
    }
    
    //MARK: - tableViewSetting
    
    func tableViewSetting() {
        tableView.backgroundColor = UIColor(named: "AccentColor")
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    //MARK: - loginButtonSetting
    
    func loginButtonSetting() {
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension SidePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell",for: indexPath) as! OptionTableViewCell
        cell.backgroundColor = UIColor(named: "AccentColor")
        cell.optionLabel.text = options[indexPath.row]
        cell.selectionStyle = .none
        
        if cell.optionLabel.text == "站點資訊" {
            cell.optionLabel.textColor = .darkGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        if option == "站點資訊" {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
