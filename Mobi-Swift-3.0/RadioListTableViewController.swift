//
//  RadioListTableViewController.swift
//  Mobi-Swift-3.0
//
//  Created by Desenvolvimento Access Mobile on 8/19/16.
//  Copyright © 2016 Access Mobile. All rights reserved.
//

import UIKit

class RadioListTableViewController: UITableViewController {
  
  
  var radios = [RadioRealm]()
  var selectedRadio = RadioRealm()
  var superSegue = String()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 120
    if superSegue == "detailGenre" {
      self.title = radios[0].genre
    } else {
      self.title = radios[0].address.city
    }

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return radios.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("radioCell", forIndexPath: indexPath) as! InitialTableViewCell
    
    cell.labelName.text = radios[indexPath.row].name
    cell.labelLocal.text = radios[indexPath.row].address.formattedLocal
    cell.imageBig.image = UIImage(named: radios[indexPath.row].thumbnail)
    cell.imageSmallOne.image = UIImage(named: "heart.png")
    cell.labelDescriptionOne.text = "\(radios[indexPath.row].likenumber)"
    cell.imageSmallTwo.image = UIImage(contentsOfFile: "")
    cell.labelDescriptionTwo.text = ""
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedRadio = radios[indexPath.row]
    performSegueWithIdentifier("detailRadio", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detailRadio" {
      let radioVC = (segue.destinationViewController as! RadioViewController)
      radioVC.actualRadio = selectedRadio
    }
  }
  
  }