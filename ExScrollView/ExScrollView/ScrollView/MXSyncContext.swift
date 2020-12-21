//
//  MXSyncContext.swift
//  ExScrollView
//
//  Created by muhlenXi on 2020/12/21.
//

import UIKit

class MXSyncContext {
    var scrollMaxOffsetY: CGFloat = 0
    
    var scrollViewContentOffset: CGPoint = .zero
    var tableViewContentOffset: CGPoint = .zero
}

extension CGFloat {
    var twoDecimals: CGFloat {
        return CGFloat(Int(self) * 100) / 100.0
    }
}
