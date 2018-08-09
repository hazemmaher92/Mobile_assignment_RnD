//
//  ViewController.swift
//  Mobile assignment RnD
//
//  Created by Hazem Maher on 8/6/18.
//  Copyright © 2018 Hazem Maher. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - Properties
    fileprivate var citiesList: CitiesList = CitiesList()
    fileprivate var cities: [City] = [City](){
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var citiesName: [String] = [String](){
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        fetchCites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Fetch Data
    
    func fetchCites() {
        cities =  citiesList.fetchData()!
    }
}

//MARK: - Table view data source

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !citiesList.isTrieSearch {
            let city = cities[indexPath.row]
            performSegue(withIdentifier: "MapSegue", sender: city.coord)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Table view data source

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesList.isTrieSearch ? citiesName.count : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell{
            if citiesList.isTrieSearch {
                let name = citiesName[indexPath.row]
                cell.textLabel?.text = name
            } else if cities.count > 0 {
                let city = cities[indexPath.row]
                cell.textLabel?.text = city.name + " , " + city.country
            }
            
            return cell
        } else {
            
            return UITableViewCell()
        }
    }
}
//MARK: - Search delegate

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        cities = citiesModel.searchCities(letters: searchText) // if use native filter swift
        if searchText.count != 0 {
            citiesName = citiesList.searchTri(letters: searchText)
        } else {
            citiesList.isTrieSearch = false
            cities = citiesList.cities //  render sorted cities as beginig
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        citiesList.isTrieSearch = false
        searchBar.text = ""
        cities = citiesList.cities //  render sorted cities as beginig
        searchBar.resignFirstResponder()
    }
}

//MARK: - Navigations

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            if let mapVC = segue.destination as? MapViewController {
                if let coord = sender as? Coord {
                    mapVC.coord = coord
                }
            }
        }
    }
}
