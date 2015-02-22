//
//  MainViewController.swift
//  Yelp
//
//  Created by Adam Crabtree on 2/17/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

let yelpConsumerKey = "krmdI-QwPwh3cbZkZKtFAQ"
let yelpConsumerSecret = "SSp6ZkfD3qI3uw357x_C05pgrR8"
let yelpAccessToken = "BpzHqJOZukat-IJTQQce0lF1mDeM0UQu"
let yelpAccessSecret = "e9jrZaLDm1tMCrXzTqnieWAlQHk"

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterDelegate {
    @IBOutlet weak var tableView: UITableView!
    lazy var searchBar = UISearchBar()
    var filterButton: UIBarButtonItem!
    
    lazy var businesses: [Business] = []
    var offset = 0
    var total = 0
    var limit = 20
    var filters = [String:String]()
    
    
    lazy var client: YelpClient = {
        return YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpAccessToken, accessSecret: yelpAccessSecret)
    }()
    lazy var filterViewController: FilterViewController = {
        let vc = FilterViewController(nibName: "FilterViewController", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        return vc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar = UISearchBar()
        searchBar.delegate = self
        self.searchBar.placeholder = "e.g. burgers, thai, seafood"
        self.navigationItem.titleView = self.searchBar
        
        
        self.filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "filterButtonTapped")
        self.navigationItem.leftBarButtonItem = self.filterButton

        self.tableView.registerNib(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "BusinessCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 85
        
//        self.search("Thai")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessCell
        let rowData = self.businesses[indexPath.row]
        
        cell.setBusiness(rowData)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //
        //        let vc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        //        vc.data = self.data?["movies"][indexPath.row]
        //        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? MovieCell {
        //            vc.thumbnail = cell.movieImage?.image
        //        }
        //
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let actualPosition = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height - self.view.frame.size.height
//
//        if (actualPosition >= contentHeight) {
//            self.client.searchWithTerm(query, success: { (request, data) -> Void in
//                self.businesses = Business.initWithBusinesses(data["businesses"] as! [NSDictionary])
//                self.tableView.reloadData()
//                }) { (request, error) -> Void in
//                    println(error)
//            }
//            
//            
//            self.businesses += businessResults
//            self.tableView.reloadData()
//        }
//    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.resetResults()
        searchBar.endEditing(true)
        println("wtf: \(searchBar.text)")
        if searchBar.text != "" {
            self.search(searchBar.text)
        }
    }
    
    func filterButtonTapped() {
        self.presentViewController(self.filterViewController, animated: true, completion: {})
    }
    
    func filter(filters: [String: String]) {
        self.filters = filters
        self.search(searchBar.text)
    }

    func search(query: String) {
        println("querying...")
        println(query)
        self.client.searchWithTerm(query, parameters: self.filters, offset: self.offset, limit: self.limit, success: {
            (request, data) -> Void in
            self.businesses = Business.initWithBusinesses(data["businesses"] as! [NSDictionary])
            self.tableView.reloadData()
            }) { (request, error) -> Void in
                println(error)
        }
    }
    
    func resetResults() {
        self.businesses = []
        self.offset = 0
        self.total = 0
    }
    
    
    
    
    
    
    
    
//    func showDetailsForResult(result: YelpBusiness) {
//        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let controller = storyboard.instantiateViewControllerWithIdentifier("Details") as DetailsViewController
//        controller.business = result
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.destinationViewController is UINavigationController {
//            let navigationController = segue.destinationViewController as UINavigationController
//            if navigationController.viewControllers[0] is FiltersViewController {
//                let controller = navigationController.viewControllers[0] as FiltersViewController
//                controller.delegate = self
//            } else if (navigationController.viewControllers[0] is DetailsViewController) {
//                let controller = navigationController.viewControllers[0] as DetailsViewController
//                
//            }
//        }
//    }
//    
//    final func onFiltersDone(controller: FiltersViewController) {
//        if self.searchBar.text != "" {
//            self.clearResults();
//            self.performSearch(self.searchBar.text)
//        }
//    }
//    
//    func synchronize(searchView: SearchViewController) {
//        self.searchBar.text = searchView.searchBar.text
//        self.results = searchView.results
//        self.total = searchView.total
//        self.offset = searchView.offset
//        self.lastResponse = searchView.lastResponse
//        
//        if self.results.count > 0 {
//            self.onResults(self.results, total: self.total, response: self.lastResponse)
//        } else {
//            self.onResultsCleared()
//        }
//    }
}
