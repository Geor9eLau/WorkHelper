//
//  HomePageViewController.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/26.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController, iCarouselDataSource, iCarouselDelegate  {
    
    
    
    @IBOutlet weak var carousel: iCarousel!
//    private lazy var colltectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 70, height:90.0)
//        layout.minimumLineSpacing = 5.0;
//        
//        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
//        let tmpCollectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - 250), collectionViewLayout: layout)
//        tmpCollectionView.delegate = self
//        tmpCollectionView.dataSource = self
//        tmpCollectionView.register(UINib.init(nibName: "ChooseCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//        tmpCollectionView.collectionViewLayout = layout
//        tmpCollectionView.backgroundColor = UIColor.clear
//        return tmpCollectionView
//    }()
    
    private var recordTf: UITextField = {
       let tmp = UITextField(frame: CGRect(x: 20, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH - 40, height: 150))
        tmp.allowsEditingTextAttributes = false
        tmp.isEnabled = false
        return tmp
    }()
    
    private var dataSource: [BodyPart] = ALL_BODY_PART_CHOICES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Page"
        carousel.type = .coverFlow
        carousel.bounces = false
        carousel.currentItemIndex = 1
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Private
    private func setupUI() {
        
        
    
    }
    
    
    // MARK: - Event Handler
    

    
    @IBAction func workoutBtnDidClicked(_ sender: UIButton) {
        let motionVC = MotionViewController(part: dataSource[carousel.currentItemIndex])
        motionVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(motionVC, animated: true)
    }
    // MARK: - iCarouselDataSource
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return dataSource.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: CarouselItemView
        let part = dataSource[index]
        if (view as? CarouselItemView) != nil{
            itemView = view as! CarouselItemView
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = CarouselItemView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        }
        itemView.imgView.image = UIImage(named: part.rawValue)
        itemView.titleLbl.text = part.rawValue
        return itemView
    }
    
    
    // MARK: - iCarouselDelegate
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
}
