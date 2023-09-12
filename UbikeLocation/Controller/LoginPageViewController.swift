//
//  LoginPageViewController.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/12.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loginButton: UIButton!
    let options = ["使用說明","收費方式","站點資訊","最新消息","活動專區"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AccentColor")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "AccentColor")
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        
    }

    
    
}

extension LoginPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell",for: indexPath) as! OptionTableViewCell
        cell.optionButton.setTitle(options[indexPath.row], for: .normal)
        cell.optionButton.setTitleColor(.white, for: .normal)
        cell.backgroundColor = UIColor(named: "AccentColor")
        cell.selectionStyle = .none
        cell.optionButton.tag = indexPath.row
        cell.optionButton.addTarget(self, action: #selector(optionButtonPressed(sender:)), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationInfo = options[indexPath.row]
       print(locationInfo)
    }
    
    
    @objc func optionButtonPressed(sender: UIButton) {
        guard let option = sender.currentTitle else { return }
        if option == "站點資訊" {
            
            
        }
    }
    
}
