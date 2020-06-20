//
//  EmployeeListViewController.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var tableViewEmployee: UITableView!
    var employees: [Employee] = []
    var filteredEmployees: [Employee] = []
    var searchController = UISearchController()
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Employees"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = Employee.createFetchRequest()
        do {
            employees = try managedContext.fetch(fetchRequest)
            if (employees.count == 0) {
                fetchEmployeeList()
            } else {
                self.filteredEmployees = self.employees
                self.tableViewEmployee.reloadData()
                print("testing : ", employees[0].value(forKeyPath: "name") ?? "12")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    
    @objc func fetchEmployeeList() {
        if let jsontString = try? String(contentsOf: URL(string: "http://www.mocky.io/v2/5d565297300000680030a986")!) {
            var dataSet = [[String: AnyObject]]()
            if let jsonData = jsontString.data(using: String.Encoding.utf8) {
                
                do {
                    dataSet = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String:AnyObject]]

                    for data in dataSet {
                        DispatchQueue.main.async { [unowned self] in
                            self.saveToCoreData(data: EmployeeModel(data))
                        }
                    }
                    DispatchQueue.main.async { [unowned self] in
                        self.filteredEmployees = self.employees
                        self.tableViewEmployee.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    
    func saveToCoreData(data: EmployeeModel) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let address = Address(context: managedContext)
        let location = Location(context: managedContext)
        let company = Company(context: managedContext)
        let employee = Employee(context: managedContext)
        
        location.lat = Double(data.address.geo.lat) ?? 0
        location.long = Double(data.address.geo.lng) ?? 0
        
        address.city = data.address.city
        address.street = data.address.street
        address.suite = data.address.suite
        address.zipcode = data.address.zipcode
        address.geo = location
        
        company.bs = data.company.bs
        company.catchPhrase = data.company.catchPhrase
        company.name = data.company.name
        
        employee.name = data.name
        employee.userName = data.username
        employee.emailAddress = data.email
        employee.imageUrl = data.profile_image
        employee.phone = data.phone
        employee.website = data.website
        employee.address = address
        employee.company = company
        
        do {
            try managedContext.save()
            employees.append(employee)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo) ")
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredEmployees = employees.filter { (employee: Employee) -> Bool in
        return employee.name.lowercased().contains(searchText.lowercased()) || employee.emailAddress.lowercased().contains(searchText.lowercased())
      }
      
      tableViewEmployee.reloadData()
    }

}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
          return filteredEmployees.count
        }
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeTableViewCell
        
        let employee: Employee
        if isFiltering {
          employee = filteredEmployees[indexPath.row]
        } else {
          employee = employees[indexPath.row]
        }

        cell.labelName.text = employee.name
        cell.labelCompanyName.text = employee.company?.name
        cell.imageViewProfile.sd_setImage(with: URL(string: employee.imageUrl ?? ""), placeholderImage: nil, options: .refreshCached, context: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailViewController") as? EmployeeDetailViewController {
            let employee: Employee
            if isFiltering {
              employee = filteredEmployees[indexPath.row]
            } else {
              employee = employees[indexPath.row]
            }

            vc.employeeDetails = employee
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}


extension EmployeeListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
