//
//  ProfileViewController.swift
//  Nice
//
//  Created by yang on 16/3/18.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return section == 0 ? 14.0 : 13.0
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
