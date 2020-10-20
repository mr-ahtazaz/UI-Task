//
//  ViewController.swift
//  Task-Ahtazaz
//
//  Created by Ahtazaz on 19/10/2020.
//  Copyright © 2020 Ahtazaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var calendarCollectionView   : UICollectionView!
    @IBOutlet weak var eventCollectionView      : UICollectionView!
    @IBOutlet weak var popularEventsTableView   : UITableView!
    
    // MARK: - Properties
    var selectedCalendarCell = -1
    
    // MARK: - Constant
    let calendarFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    let eventFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    // MARK: - UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRequestData()
    }
    
    // MARK: - WebService
    func getRequestData() {
        let obj = APIClient(_httpUtility: HttpUtility())
        
        obj.ahtazazTask(request: "https://pokeapi.co/api/v2/pokemon/1") { result in
            
            switch result {
                
            case .success(let result) :
                
                print(result)
                
            case .failure(let error) :
                print(error.rawValue)
            }
        }
    }
    
    // MARK: - Functions
    func setupUI() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.collectionViewLayout = calendarFlowLayout
        calendarCollectionView.isPagingEnabled = true
        calendarCollectionView.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        eventCollectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        eventCollectionView.collectionViewLayout = eventFlowLayout
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        eventCollectionView.isPagingEnabled = true
        
        popularEventsTableView.dataSource = self
        popularEventsTableView.delegate = self
        popularEventsTableView.separatorStyle = .none
    }
}



// MARK: - UICollectionView Implementation
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    /// cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == calendarCollectionView {
            
            let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DateCell
            
            if selectedCalendarCell == indexPath.row {
                cell.dateLabel.textColor = .black
                cell.weekLabel.textColor = .black
                cell.layer.cornerRadius = 8
                cell.backgroundColor = UIColor.systemOrange
            }
            else {
                cell.dateLabel.textColor = .white
                cell.weekLabel.textColor = .white
                cell.layer.cornerRadius = 0
                cell.backgroundColor = .clear
            }
            
            return cell
        }
        else {
            let cell = eventCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EventCell
            return cell
        }
        
    }
    
    /// didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == calendarCollectionView {
            
            if selectedCalendarCell == indexPath.row {
                selectedCalendarCell = -1
                calendarCollectionView.reloadData()
                return
            }
            
            selectedCalendarCell = indexPath.row
            calendarCollectionView.reloadData()
        }
    }
    
    /// sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == calendarCollectionView {
            let width = (calendarCollectionView.frame.size.width - 60) / 7
            return CGSize(width: width, height: calendarCollectionView.frame.size.height)
        }
        else {
            let width = (eventCollectionView.frame.size.width - 80 - 20) / 2
            return CGSize(width: width, height: eventCollectionView.frame.size.height)
        }
    }
    
    /// minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}


// MARK: - UITableView Implementation
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    /// cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popularEventsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectedBackgroundView = UIView()
        return cell
    }
    
    /// heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  120
    }
}
