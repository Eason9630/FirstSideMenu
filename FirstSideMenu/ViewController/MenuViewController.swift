//
//  MenuViewController.swift
//  FirstSideMenu
//
//  Created by 林祔利 on 2023/9/14.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOption)
}

class MenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    weak var delegate:MenuViewControllerDelegate?

    enum MenuOption: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case addRating = "App Rating"
        case shareApp = "Share App"
        case setting = "Setting"
        
        var imageName: String {
            switch self {
                
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .addRating:
                return "star"
            case .shareApp:
                return "message"
            case .setting:
                return "gear"
            }
        }
    }
    

    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let greyColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = greyColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOption.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOption.allCases[indexPath.row].imageName)
        cell.backgroundColor = greyColor
        cell.contentView.backgroundColor = greyColor
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOption.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
        
    }
    
}
