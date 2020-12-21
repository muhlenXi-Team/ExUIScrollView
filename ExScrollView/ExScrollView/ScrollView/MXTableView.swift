//
//  MXTableView.swift
//  ExScrollView
//
//  Created by muhlenXi on 2020/12/21.
//

import UIKit

// MARK: - MXScrollView

class MXScrollView: UIScrollView {
    var syncContext: MXSyncContext?
    
    override var contentOffset: CGPoint {
        didSet {
            guard contentOffset.y != oldValue.y, let context = syncContext else { return }

            if context.tableViewContentOffset.y > 0 || contentOffset.y > context.scrollMaxOffsetY {
                contentOffset.y = context.scrollMaxOffsetY
                scrollsToTop = false
            } else {
                scrollsToTop = true
            }

            context.scrollViewContentOffset = contentOffset
        }
    }
}

// MARK: - MXTableView

class MXTableView: UITableView {
    weak var syncScrollView: UIScrollView?
    var syncContext: MXSyncContext?
    
    override var contentOffset: CGPoint {
        didSet {
            guard contentOffset.y != oldValue.y, let context = syncContext  else { return }

            if context.scrollViewContentOffset.y.twoDecimals < context.scrollMaxOffsetY.twoDecimals {
                contentOffset.y = 0
                scrollsToTop = false
            } else {
                scrollsToTop = true
            }

            context.tableViewContentOffset = contentOffset
        }
    }
    
}

extension MXTableView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.view == syncScrollView
    }
}
