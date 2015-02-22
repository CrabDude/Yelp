//
//  FilterViewController.swift
//  Yelp
//
//  Created by Adam Crabtree on 2/19/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var delegate: FilterDelegate?
    var filters = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        cancelButton.target = self
        cancelButton.action = Selector("closeTapped:")
        filterButton.target = self
        filterButton.action = Selector("filterTapped:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - tableView
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterTypes.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filterType = filterTypes[section]
        return filterType.isOpen ? filterType.options.count : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
//        let control = UISegmentedControl(items: ["$", "$$", "$$$", "$$$$"])
        let labelView = UILabel(frame: cell.frame)
        labelView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        let filterType = filterTypes[indexPath.section]
        labelView.text = filterType.isOpen ? filterType.options[indexPath.row].displayName : filterType.options[filterType.selectedIndex].displayName
        cell.addSubview(labelView)

        if indexPath.section == 0 {
            let switchView = UISwitch()
            switchView.addTarget(self, action: Selector("switchStateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            cell.accessoryView = switchView
        }
        
        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: NSInteger) -> String? {
        return filterTypes[section].name
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var filterType = filterTypes[indexPath.section]
        if indexPath.row == 0 && !filterType.isOpen {
            filterType.isOpen = true
        } else {
            filterType.selectedIndex = indexPath.row
            filterType.isOpen = false
            self.filters[filterType.key] = filterType.options[filterType.selectedIndex].value
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated:true)
        self.tableView.reloadData()
    }

    // MARK: - events
    
    func closeTapped(sender: UIButton!) {
        println("closeTapped")
        close()
    }
    
    func filterTapped(sender: UIButton!) {
        println("filterTapped")
        self.delegate?.filter(self.filters)
        close()
    }
    
    
    func switchStateChanged(sender:UISwitch!) {
        println("switchStateChanged")
        self.filters["deals_filter"] = sender.on ? "true" : "false"
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion:{})
    }
}

protocol FilterDelegate {
    func filter(filters: [String: String])
}
