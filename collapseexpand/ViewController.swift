//
//  ViewController.swift
//  collapseexpand
//
//  Created by Vishal Gandhi on 11/28/15.
//  Copyright © 2015 Vishal Gandhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var items : NSArray! = NSArray()
    var itemsInTable : NSMutableArray! = NSMutableArray()
    
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let dict : NSDictionary = NSDictionary.init(contentsOfFile: NSBundle.mainBundle().pathForResource("data", ofType: "plist")!)!
        items = dict.valueForKey("Items") as! NSArray
        itemsInTable.addObjectsFromArray(items as [AnyObject])
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInTable.count
    }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let title : String! = itemsInTable.objectAtIndex(indexPath.row).valueForKey("Name") as! String
   
        return createCell(title, indexPath: indexPath, tableView: tableView)
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let dict : NSDictionary! = itemsInTable.objectAtIndex(indexPath.row) as! NSDictionary
        
        if (dict.valueForKey("SubItems") != nil)
        {
            let arr : NSArray! = dict.valueForKey("SubItems") as! NSArray
            var isTableExpanded : Bool! = false
            
            for subitems in arr
            {
                let index : Int = itemsInTable.indexOfObjectIdenticalTo(subitems)
                isTableExpanded = (index>0 && index != NSIntegerMax)
                if isTableExpanded == true
                {
                    break;
                }
            }
            if isTableExpanded == true
            {
                print("expanded")
                collapseRows(arr)
            }
            else
            {
                var count : NSInteger = indexPath.row + 1
                let  arrCells : NSMutableArray = NSMutableArray()
                for dict in arr
                {
                    arrCells.addObject(NSIndexPath(forRow:count, inSection: 0))
                    itemsInTable.insertObject(dict, atIndex:count++)
                }
                tblView.insertRowsAtIndexPaths(arrCells.copy() as! [NSIndexPath], withRowAnimation:                    UITableViewRowAnimation.None)
            }
            
        }
    }
    
    func createCell(title : String,indexPath:NSIndexPath, tableView:UITableView) -> UITableViewCell
    {
        
        let CellIdentifier: String! = "kCell"
    
        let cell =  tableView.dequeueReusableCellWithIdentifier(CellIdentifier,forIndexPath: indexPath) as! ExpandableTableViewCell
        
        let bgView : UIView! = UIView()
        bgView.backgroundColor = UIColor.grayColor()
        
        cell.selectedBackgroundView = bgView;
        cell.lblTitle.text = title;
        cell.lblTitle.textColor = UIColor.blackColor()
        
        let dict : NSDictionary! = itemsInTable.objectAtIndex(indexPath.row) as! NSDictionary
        
        if (dict.valueForKey("SubItems") != nil)
        {
            cell.btnExpand.alpha = 1.0;
            cell.btnExpand.addTarget(self, action:"showSubItems:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        else
        {
            cell.btnExpand.alpha = 0.0;
        }
        
        
        return cell;
    }
    
    
    func collapseRows(arr:NSArray)
    {
        for dict in arr
        {
            print(dict)
            let indexToRemove : Int = itemsInTable.indexOfObjectIdenticalTo(dict)
            let arrInner : NSArray? = dict.valueForKey("SubItems") as? NSArray
            if arrInner != nil
            {
                if  arrInner!.count > 0
                {
                    collapseRows(arrInner!)
                }
            }
        
            if itemsInTable.indexOfObjectIdenticalTo(dict) != NSNotFound
            {
                itemsInTable.removeObjectIdenticalTo(dict)
                tblView.deleteRowsAtIndexPaths([NSIndexPath(forRow:indexToRemove, inSection: 0)], withRowAnimation:UITableViewRowAnimation.None)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

