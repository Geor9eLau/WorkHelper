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
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - CHOOSE_ITEM_PADDING * 2) / 3, height: (SCREEN_WIDTH - CHOOSE_ITEM_PADDING * 2) / 3)
        layout.minimumLineSpacing = 5.0;
        let tmpCollectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - 250), collectionViewLayout: layout)
        tmpCollectionView.delegate = self
        tmpCollectionView.dataSource = self
        tmpCollectionView.register(UINib.init(nibName: "ChooseCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        tmpCollectionView.collectionViewLayout = layout
        tmpCollectionView.backgroundColor = UIColor.clear
        return tmpCollectionView
    }()
    
    private var dataSource: [BodyPart] = DataManager.userChosenParts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButtons()
        title = "Home Page"
        view.addSubview(self.colltectionView)
        
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Private
    
    func setupButtons() {
        let beginBtn = UIButton(frame: CGRect(x: (SCREEN_WIDTH / 2 - 150) / 2, y: SCREEN_HEIGHT - 49 - 80, width: 150, height: 50))
        beginBtn.addTarget(self, action: #selector(beginBtnDidClicked), for: .touchUpInside)
        beginBtn.setTitle("Start", for: .normal)
        beginBtn.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(beginBtn)
        
        let finishBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH / 2 + (SCREEN_WIDTH / 2 - 150) / 2, y:SCREEN_HEIGHT - 49 - 80, width: 150, height: 50))
        finishBtn.addTarget(self, action: #selector(finishBtnDidClicked), for: .touchUpInside)
        finishBtn.setTitle("Finish", for: .normal)
        finishBtn.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(finishBtn)
    }
    
    // MARK: - Event Handler
    @objc private func beginBtnDidClicked() {
        
    }
    
    @objc private func finishBtnDidClicked() {
        
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChooseCollectionCell
        let part = dataSource[indexPath.row]
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
