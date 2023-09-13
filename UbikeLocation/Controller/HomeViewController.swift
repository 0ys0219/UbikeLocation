//
//  ViewController.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/12.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet weak var locationInfoLabel: UILabel!
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var data = ["abc","aa","ccb","ABC","sss"]
    let searchTableView = UITableView()
    var locationInfoManager = LocationInfoManager()
    var locationArray: [LocationInfo] = []
    var area: Set<String> = []
    var areaArray: [String] = []
    var filterArray: [LocationInfo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let fullSize = UIScreen.main.bounds.size
        
        locationInfoManager.delegate = self
        locationInfoManager.fetchLocationInfo()
        navigationBarSetting()
        resultTableView.delegate = self
        resultTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
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

        view.addSubview(searchTableView)
        searchTableView.isHidden = true
        searchTableView.register(UINib(nibName: "SearchTextCell", bundle: nil), forCellReuseIdentifier: "SearchTextCell")
        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -380).isActive = true
        searchTableView.rowHeight = 44
        searchTableView.separatorStyle = .none
        searchTableView.backgroundColor = .secondarySystemBackground
        searchTableView.layer.cornerRadius = 10
        
        
        resultTableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
//        resultTableView.translatesAutoresizingMaskIntoConstraints = false
//        resultTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
//        resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
//        resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        resultTableView.separatorStyle = .none
        resultTableView.backgroundColor = .secondarySystemBackground
        resultTableView.layer.cornerRadius = 10
        
        
    }
    

    @objc func closeKeyboard() {
//        searchTableView.isHidden = true
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
//        if tableView == resultTableView {
//            print(filterArray.count)
//            return filterArray.count
//        }
        
//        else if tableView == searchTableView {
//            print(areaArray.count)
//            return areaArray.count
//        }
//       print(123)
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == searchTableView {
//            let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTextCell", for: indexPath) as! SearchTextCell
//            cell.searchTextLabel.text = areaArray[indexPath.row]
//            cell.backgroundColor = .secondarySystemBackground
//
//            return cell
//        } else if tableView == resultTableView {
//            let cell = resultTableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
//            cell.cityLabel.text = "台北市"
//            cell.areaLabel.text = filterArray[indexPath.row].area
//
//            cell.locationLabel.text = filterArray[indexPath.row].location
//            cell.selectionStyle = .none
//            cell.backgroundColor = .secondarySystemBackground
//            print(cell)
//            return cell
//        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchBar.text = areaArray[indexPath.row]
        print(searchBar.text)
    }
    
    
    
}



extension HomeViewController: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print(searchText)
        if !searchText.isEmpty {
//            searchTableView.isHidden = false
        } else {
            searchTableView.isHidden = true
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            if let text = searchBar.text {
                self.filterArray = self.locationArray.filter { location in
                    location.area == text
                }
                print(self.filterArray)
                self.resultTableView.reloadData()
            }
        }
    }
   
    
    
}

extension HomeViewController: LocationInfoDelegate {

    func saveLocationInfo(from results: [LocationInfoData])  {
        DispatchQueue.main.async {
            for result in results {
                self.locationArray.append(LocationInfo(area: result.sarea, location: result.sna))
                self.filterArray.append(LocationInfo(area: result.sarea, location: result.sna))
                self.area.insert(result.sarea)
            }
            self.areaArray = Array(self.area).sorted()
            self.resultTableView.reloadData()
            self.searchTableView.reloadData()
        }
    }
}
