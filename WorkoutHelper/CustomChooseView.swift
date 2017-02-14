//
//  CustomChooseView.swift
//  WorkoutHelper
//
//  Created by George on 2016/12/13.
//  Copyright © 2016年 George. All rights reserved.
//

import UIKit


protocol CustomChooseViewDelegate: NSObjectProtocol {
    func choose(item: Any)
}

class CustomChooseView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    enum FromType {
        case setting
        case training
    }
    
    public var hasSelectableChoice: Bool {
        return self.dataSource.count > 0
    }
    
    public var part: BodyPart
    weak var delegate: CustomChooseViewDelegate?
    private var dataSource: [PartMotion] = []

    private lazy var colltectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.itemWidth, height: self.itemWidth)
        layout.minimumLineSpacing = 5.0;
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        let tmpCollectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH , height: SCREEN_HEIGHT - 200), collectionViewLayout: layout)
        tmpCollectionView.delegate = self
        tmpCollectionView.dataSource = self
        tmpCollectionView.register(UINib.init(nibName: "ChooseCollectionCell", bundle: nil), forCellWithReuseIdentifier: "chooseCell")
        tmpCollectionView.collectionViewLayout = layout
        tmpCollectionView.backgroundColor = UIColor.clear
        return tmpCollectionView
    }()
    
    
    private var itemWidth: Double {
        return (SCREEN_WIDTH - CHOOSE_ITEM_PADDING * 4) / 3
    }
    
    
    // MARK: - Initialize
    
    init(_ frame: CGRect, part: BodyPart) {
        self.part = part
        super.init(frame: frame)
        backgroundColor = Util.RGBColor(r: 255, g: 255, b: 255, a: 0.80)
        self.addSubview(self.colltectionView)
        dataSource = {
            switch self.part{
            case .back: return ALL_BACK_MOTION_CHOICES
            case .shoulder: return ALL_SHOULDER_MOTION_CHOICES
            case .leg: return ALL_LEG_MOTION_CHOICES
            }
        }()
        colltectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Event handlers
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    // MARK: - UICollectionDataSource
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cellData = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooseCell", for: indexPath) as! ChooseCollectionCell
        cell.imgView.image = UIImage(named: "george")
        cell.chooseLbl.text = cellData.motionName

        return cell
    }
    
    // MARK - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        guard (delegate != nil) else {return}
        
        self.removeFromSuperview()
        delegate?.choose(item: item)
    }
    
}
