//
//  CalendarCell.swift
//  NimalCalendar
//
//  Created by Ronaldo Avalos on 16/04/24.
//

import UIKit
import FSCalendar

class CalendarCell: FSCalendarCell {

    private let preferredWidth: CGFloat = 40.0
   private let cellSpacing: CGFloat = 8.0

   override init(frame: CGRect) {
       super.init(frame: CGRect(x: 0, y: 0, width: preferredWidth, height: preferredWidth))
       
       let view = UIView(frame: self.bounds)
       view.backgroundColor = .primary
       self.backgroundView = view;
       setupLayers()
       
   }

   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       setupLayers()
   }

   func setupLayers() {
       let backgroundLayer = CALayer()
       backgroundLayer.backgroundColor = UIColor.clear.cgColor
       self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
       contentView.layer.addSublayer(backgroundLayer)
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       contentView.frame = CGRect(x: 0, y: 0, width: preferredWidth, height: preferredWidth)
       contentView.layer.sublayers?.first?.frame = bounds
   }

}


extension FSCalendarCell {
    var cellBackgroundColor: UIColor? {
        get {
            return backgroundView?.backgroundColor
        }
        set {
            backgroundView?.backgroundColor = newValue
        }
    }
}
