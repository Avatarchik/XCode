//
//  UserTableViewController.swift
//  Instagram
//
//  Created by Gray Karegeannes on 4/15/15.
//  Copyright (c) 2015 Gray Karegeannes. All rights reserved.
//

import UIKit
import Parse


class UserTableViewController: UITableViewController {

    var usernames = ["nil"]
    var userids = ["nil"]
    var isFollowing = ["":false]
    
    var refresher: UIRefreshControl!
    
    func refresh(){
        println("refreshed")
        
        
        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            
            
            if let users = objects {
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                
                for object in users{
                    println(object)
                    if let user = object as? PFUser{
                        if user.objectId != PFUser.currentUser()?.objectId {
                            
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                            
                            var query = PFQuery(className: "followers")
                            
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                if let objects = objects{
                                    
                                    if objects.count > 0 {
                                        self.isFollowing[user.objectId!] = true
                                    }
                                        
                                    else {
                                        self.isFollowing[user.objectId!] = false
                                        
                                    }
                                }
                                if self.isFollowing.count == self.usernames.count {
                                    self.tableView.reloadData()
                                     self.refresher.endRefreshing()
                                }
                            })
                        }
                    }
                }
            }
            
            
            
        })
        
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        refresh()
        
        self.tableView.addSubview(refresher)

        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
        
            
            if let users = objects {
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                
                for object in users{
                    println(object)
                    if let user = object as? PFUser{
                        if user.objectId != PFUser.currentUser()?.objectId {
                        
                        self.usernames.append(user.username!)
                        self.userids.append(user.objectId!)
                            
                            var query = PFQuery(className: "followers")
                            
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                if let objects = objects{
                                    
                                    if objects.count > 0 {
                                        self.isFollowing[user.objectId!] = true
                                    }
                                        
                                    else {
                                        self.isFollowing[user.objectId!] = false
                                        
                                    }
                                }
                                if self.isFollowing.count == self.usernames.count {
                                    self.tableView.reloadData()
                                    
                                }
                            })
                        }
                    }
                }
            }
            
            
            
            })
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = usernames[indexPath.row]
        
        let followedObjectId = userids[indexPath.row]
        
        if isFollowing[followedObjectId] == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        let followedObjectId = userids[indexPath.row]
        if self.isFollowing[followedObjectId] == false {
            
            self.isFollowing[followedObjectId] = true
            //add check mark next to followed users
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            //follow a user
            var following = PFObject(className: "followers")
            
            following["following"] = userids[indexPath.row]
            following["follower"] = PFUser.currentUser()?.objectId
            
            following.saveInBackground()
        }
        else {
            self.isFollowing[followedObjectId] = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className: "followers")
            
            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("following", equalTo: userids[indexPath.row])
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects{
                    
                    for object in objects {
                        object.deleteInBackground()
                        
                    }
                }
                })

        }
    }

}
