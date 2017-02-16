//
//  DataDetailViewController.swift
//  WorkoutHelper
//
//  Created by George on 2017/2/15.
//  Copyright © 2017年 George. All rights reserved.
//

import UIKit

class DataDetailViewController: BaseViewController, iCarouselDelegate, iCarouselDataSource, UITableViewDelegate, UITableViewDataSource {

    
    var part: BodyPart?
    private var trainingRecords = [Training]()
    @IBOutlet weak var carousel: iCarousel!

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .linear
        carousel.bounces = false
        self.trainingRecords = DataManager.sharedInstance.getAllTrainingRecord(motion: carouselDataSource[0])
        tableView.register(DataDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var carouselDataSource: [PartMotion] = {
        switch self.part! {
        case .back:
            return ALL_BACK_MOTION_CHOICES
        case .shoulder:
            return ALL_SHOULDER_MOTION_CHOICES
        case .leg:
            return ALL_LEG_MOTION_CHOICES
        }
    }()
    
    private let tableViewRows: [DataDetailCellType] = [.weight, .repeats, .time]
    
    // MARK: - iCarouselDataSource
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.carouselDataSource.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: CarouselItemView
        let motion = carouselDataSource[index]
        if (view as? CarouselItemView) != nil{
            itemView = view as! CarouselItemView
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = CarouselItemView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        }
        itemView.imgView.image = UIImage(named: "george")
//        itemView.imgView.backgroundColor = UIColor.brown
        itemView.titleLbl.text = motion.motionName
        return itemView
    }
    
    
    // MARK: - iCarouselDelegate
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        let motion = carouselDataSource[carousel.currentItemIndex]
        self.trainingRecords = DataManager.sharedInstance.getAllTrainingRecord(motion: motion)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataDetailTableViewCell
        cell.titleLbl.text = tableViewRows[indexPath.row].rawValue
        cell.type = tableViewRows[indexPath.row]
        cell.update(records: self.trainingRecords)
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
