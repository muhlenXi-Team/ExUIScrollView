//
//  ViewController.swift
//  ExScrollView
//
//  Created by muhlenXi on 2020/12/21.
//

import UIKit

fileprivate let screenWidth = UIScreen.main.bounds.size.width
fileprivate let screenHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {
    
    
    private lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    private lazy var scrollView: MXScrollView = {
        let scroll = MXScrollView()
        scroll.backgroundColor = UIColor.orange
        return scroll
    }()
    
    private lazy var tableView: MXTableView = {
        let table = MXTableView()
        table.backgroundColor = .white
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
    }
    
    // MARK: Private method
    func setupSubviews() {
        self.view.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(scrollView)
        let contentHeight: CGFloat = screenHeight-88
        scrollView.frame = CGRect(x: 0, y: 88, width: screenWidth, height: contentHeight)
        scrollView.contentSize = CGSize(width: 0, height: contentHeight*CGFloat(1.5))
        
        let greenHeight: CGFloat = 100
        scrollView.addSubview(greenView)
        greenView.frame = CGRect(x: 0, y: contentHeight*0.5-greenHeight, width: screenWidth, height: greenHeight)
        
        scrollView.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: contentHeight*0.5, width: screenWidth, height: contentHeight-greenHeight)
        
        
        let syncContext = MXSyncContext()
        syncContext.scrollMaxOffsetY = greenView.frame.origin.y
        
        scrollView.syncContext = syncContext

        tableView.syncContext = syncContext
        tableView.syncScrollView = scrollView
    }
}

// MARK: UITableViewDataSource / UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section) --> \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


