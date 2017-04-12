//
//  CharacterGalleryFlowLayout.swift
//  DnDInventoryManager
//
//  Created by Mike Miksch on 4/11/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

class CharacterGalleryFlowLayout: UICollectionViewFlowLayout {
    
    var columns = 2
    var rows = 3
    let spacing: CGFloat = 10.0
    
    var screenWidth : CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight : CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var itemWidth : CGFloat {
        let avaialbleScreen = screenWidth - (CGFloat(self.columns) * self.spacing)
        return avaialbleScreen / CGFloat(self.columns)
    }
    
    var itemHeight: CGFloat {
        let availableScreen = screenHeight - (CGFloat(self.rows) * self.spacing)
        return availableScreen / CGFloat(self.rows)
    }
    
    init(columns : Int = 2) {
        self.columns = columns
        
        super.init()
        
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
