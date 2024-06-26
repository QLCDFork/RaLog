//
//  LogListViewController.swift
//  RaLogDemo
//
//  Created by Rakuyo on 2020/9/2.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import RaLog
import SnapKit
import Then
import UIKit

// MARK: - LogListViewController

class LogListViewController: UITableViewController {
    private let logs: [Log]
    
    private lazy var label = UILabel().then {
        $0.text = "Empty Data"
    }
    
    init(logs: [Log]?) {
        self.logs = logs ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log.deinit(self)
    }
}

// MARK: - The life cycle

extension LogListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log List (\(logs.count))"
        
        tableView.tableFooterView = UIView()
        
        if logs.isEmpty {
            view.addSubview(label)
            
            label.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(50)
            }
            
            label.setContentHuggingPriority(.required, for: .vertical)
            label.setContentHuggingPriority(.required, for: .horizontal)
            
        } else {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Log.appear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Log.disappear(self)
    }
}

// MARK: - UITableViewDataSource

extension LogListViewController {
    
    override open func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        logs.count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.textLabel?.do {
            var string = logs[indexPath.row].logedStr
            
            if string.hasPrefix("\n") { string.removeFirst() }
            if string.hasSuffix("\n") { string.removeLast() }
            
            $0.text = string
            $0.numberOfLines = 0
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
