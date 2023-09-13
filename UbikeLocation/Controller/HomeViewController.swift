//
//  ViewController.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/12.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var locationInfoLabel: UILabel!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    let searchTableView = UITableView()
    let resultTableView = UITableView()
    let titleTableView = UITableView()
    var locationInfoManager = LocationInfoManager()
    var locationArray: [LocationInfo] = []
    var area: Set<String> = []
    var areaArray: [String] = []
    var searchArea: [String] = []
    var filterArray: [LocationInfo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationInfoManager.delegate = self
        locationInfoManager.fetchLocationInfo()
        navigationBarSetting()
        resultTableView.dataSource = self
        resultTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        titleTableView.dataSource = self
        titleTableView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .bookmark, state: .normal)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.placeholder = "搜尋站點"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.frame = CGRect(x: 0, y: 0, width: 340, height: 50)
        searchBar.topAnchor.constraint(equalTo: locationInfoLabel.bottomAnchor, constant: 5).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        
        view.addSubview(resultTableView)
        view.addSubview(titleTableView)
        view.addSubview(searchTableView)
        
        searchTableView.isHidden = true
        searchTableView.register(UINib(nibName: "SearchTextCell", bundle: nil), forCellReuseIdentifier: "SearchTextCell")
        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -380).isActive = true
        searchTableView.rowHeight = 50
        searchTableView.separatorStyle = .none
        searchTableView.backgroundColor = .secondarySystemBackground
        searchTableView.layer.cornerRadius = 10
        
        
        titleTableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        titleTableView.backgroundColor = UIColor(named: "AccentColor")
        titleTableView.layer.cornerRadius = 0
        
        titleTableView.translatesAutoresizingMaskIntoConstraints = false
        titleTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        titleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        titleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        titleTableView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleTableView.separatorStyle = .none
        titleTableView.layer.borderWidth = 0.5
        titleTableView.layer.borderColor = UIColor.lightGray.cgColor
        titleTableView.layer.cornerRadius = 10
        titleTableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        resultTableView.register(UINib(nibName: "ResultDetailCell", bundle: nil), forCellReuseIdentifier: "ResultDetailCell")
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.topAnchor.constraint(equalTo: titleTableView.bottomAnchor, constant: 0).isActive = true
        resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        resultTableView.rowHeight = 80
        resultTableView.separatorStyle = .none
        resultTableView.backgroundColor = .secondarySystemBackground
        resultTableView.layer.cornerRadius = 10
        resultTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        resultTableView.layer.borderWidth = 0.5
        resultTableView.layer.borderColor = UIColor.lightGray.cgColor
        
        
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == resultTableView {
            if filterArray.isEmpty {
                return locationArray.count
            } else {
                return filterArray.count
            }
        }
        
        else if tableView == searchTableView {
            if searchArea.isEmpty {
                return areaArray.count
            } else {
                return searchArea.count
            }
        } else if tableView == titleTableView {
            return 1
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchTableView {
            let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTextCell", for: indexPath) as! SearchTextCell
            if searchArea.isEmpty {
                cell.searchTextLabel.text = areaArray[indexPath.row]
            } else {
                cell.searchTextLabel.text = searchArea[indexPath.row]
            }
            cell.backgroundColor = .secondarySystemBackground
            
            return cell
        } else if tableView == resultTableView {
            let cell = resultTableView.dequeueReusableCell(withIdentifier: "ResultDetailCell", for: indexPath) as! ResultDetailCell
            if filterArray.isEmpty {
                cell.cityLabel.text = "台北市"
                cell.areaLabel.text = locationArray[indexPath.row].area
                
                cell.locationLabel.text = locationArray[indexPath.row].location
            } else {
                cell.cityLabel.text = "台北市"
                cell.areaLabel.text = filterArray[indexPath.row].area
                
                cell.locationLabel.text = filterArray[indexPath.row].location
            }
            cell.selectionStyle = .none
            if indexPath.row % 2 != 0 {
                cell.backgroundColor = .white
            } else {
                cell.backgroundColor = .secondarySystemBackground
            }
            return cell
        } else if tableView == titleTableView {
            let cell = titleTableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
            cell.cityTitleLabel.text = "縣市"
            cell.areaTitleLabel.text = "區域"
            cell.locationTitleLabel.text = "站點名稱"
            cell.backgroundColor = UIColor(named: "AccentColor")
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchTableView {
            if searchArea.isEmpty {
                searchBar.text = areaArray[indexPath.row]
                searchBar.searchTextField.textColor = UIColor(named: "AccentColor")
                reloadResult()
                searchTableView.isHidden = true
                searchTableView.deselectRow(at: indexPath, animated: true)
                
            } else {
                searchBar.text = searchArea[indexPath.row]
                searchBar.searchTextField.textColor = UIColor(named: "AccentColor")
                reloadResult()
                searchTableView.isHidden = true
                searchTableView.deselectRow(at: indexPath, animated: true)
                
            }
        }
        
    }
    
    
    
}



extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            searchBar.searchTextField.textColor = .black
            searchBar.placeholder = "搜尋地點"
            searchTableView.isHidden = false
        } else {
            searchBar.searchTextField.textColor = .black
            searchBar.placeholder = "搜尋地點"
            searchTableView.isHidden = true
        }
        DispatchQueue.main.async {
            self.searchArea = self.areaArray.filter { $0.contains(searchText) }
            
            self.searchTableView.reloadData()
            
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        reloadResult()
    }
    func reloadResult() {
        DispatchQueue.main.async {
            if let text = self.searchBar.text {
                self.filterArray = self.locationArray.filter { $0.area.contains(text) }
                self.searchBar.searchTextField.textColor = UIColor(named: "AccentColor")
                self.resultTableView.reloadData()
                
            }
            if self.filterArray.isEmpty {
                self.searchBar.text = ""
                self.searchBar.placeholder = "查無此地點"
            }
            self.searchTableView.isHidden = true
            self.view.endEditing(true)
        }
    }
    
    
}

extension HomeViewController: LocationInfoDelegate {
    
    func saveLocationInfo(from results: [LocationInfoData])  {
        DispatchQueue.main.async {
            for result in results {
                let removedFrontWordFromLocation = result.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
                self.locationArray.append(LocationInfo(area: result.sarea, location: removedFrontWordFromLocation))
                self.area.insert(result.sarea)
            }
            self.areaArray = Array(self.area).sorted()
            self.searchTableView.reloadData()
            self.resultTableView.reloadData()
        }
    }
}
