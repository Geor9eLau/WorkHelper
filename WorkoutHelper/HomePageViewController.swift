//
//  HomePageViewController.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/26.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    private lazy var colltectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height:90.0)
        layout.minimumLineSpacing = 5.0;
        
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        let tmpCollectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - 250), collectionViewLayout: layout)
        tmpCollectionView.delegate = self
        tmpCollectionView.dataSource = self
        tmpCollectionView.register(UINib.init(nibName: "ChooseCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        tmpCollectionView.collectionViewLayout = layout
        tmpCollectionView.backgroundColor = UIColor.clear
        return tmpCollectionView
    }()
    
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
        view.addSubview(self.colltectionView)
        
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Private
    private func setupUI() {
        
        
    
    }
    
    
    // MARK: - Event Handler
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChooseCollectionCell
        let part = dataSource[indexPath.row]
        cell.imgView.image = UIImage(named: "\(part.rawValue)")
        cell.chooseLbl.text = part.rawValue
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let motionVC = MotionViewController(part: dataSource[indexPath.row])
        motionVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(motionVC, animated: true)
    }
    
}
