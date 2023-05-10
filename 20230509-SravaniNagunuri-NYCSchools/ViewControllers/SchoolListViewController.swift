//
//  SchoolListViewController.swift
//  20230509-SravaniNagunuri-NYCSchools
//
//  Created by Sravani Nagunuri on 5/9/23.
//

import UIKit

class SchoolListViewController: UIViewController {
    
    //MARK: - private outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataAvailable: UILabel!
    @IBOutlet weak var schoolListTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var selectedSchool: School?
    let spinner = UIActivityIndicatorView(style: .large)
    var indexArray: [String]?
    
    lazy var listViewModel = SchoolsListViewModel()
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        spinner.color = .systemBackground
        addRefreshControl()
        getSchoolsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "NYC Schools"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    // MARK: - Private functions
    
    //add pull to refresh view
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        if let refreshControl = refreshControl {
            refreshControl.tintColor = .white
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes:[NSAttributedString.Key.foregroundColor: UIColor.systemBackground])
            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            self.schoolListTableView.refreshControl = refreshControl
        }
    }
    
    /// Fetch schools list from view model which will hit the api and convert them to models
    func getSchoolsData() {
        
        showActivityIndicator()
        listViewModel.fetchSchoolsListData { [weak self] error in
            guard let strongSelf = self else {
                return
            }
            defer {
                strongSelf.hideActivityIndicator()
                DispatchQueue.main.async {
                    strongSelf.schoolListTableView.reloadData()
                }
            }
            if let error = error {
                Utilities.alert(title: "Error", message: error.localizedDescription, contoller: strongSelf)
            }
        }
    }
    
    /// show activity indicator on main queue
    private func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.startAnimating()
            self?.schoolListTableView.backgroundView = self?.spinner
            self?.noDataAvailable.isHidden = true
            
        }
    }
    
    /// hide activity indicator on main queue
    private func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
            self?.spinner.hidesWhenStopped = true
            self?.refreshControl?.endRefreshing()
        }
    }
    
    /// refresh school data
    @objc func refresh(_ sender: AnyObject) {
        getSchoolsData()
    }
}

// MARK: - SearchBar delegate
extension SchoolListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        listViewModel.filterSchools(searchText: searchBar.text ?? "")
        schoolListTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        listViewModel.filterSchools(searchText: searchBar.text ?? "")
        schoolListTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listViewModel.filterSchools(searchText: searchBar.text ?? "")
        schoolListTableView.reloadData()
    }
}

// MARK: - Table view data source
extension SchoolListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataAvailable.isHidden = (listViewModel.filteredSchools?.count != 0)
        return listViewModel.filteredSchools?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customSchoolDetailsCell") as? SchoolDetailsTableViewCell {
            if let school = listViewModel.filteredSchools?[indexPath.row] {
                cell.configureSchoolData(school: school)
            }
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedSchool = listViewModel.filteredSchools?[indexPath.row]
        return indexPath
    }
}

//MARK: - tableview delegate

extension SchoolListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! SchoolDetailsViewController
        detailsVC.school = selectedSchool
        self.navigationController?.present(detailsVC, animated: true, completion: nil)
    }
}


