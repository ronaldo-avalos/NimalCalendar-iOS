//
//  ViewController.swift
//  NimalCalendar
//
//  Created by Ronaldo Avalos on 13/04/24.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

    @IBOutlet weak var widgthConstrainButton: NSLayoutConstraint!
    
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var calendarView: FSCalendar!
    
    //Valariable
    let addEventButtonWidth : CGFloat = 288
    let addEventButtonHeight : CGFloat  = 54
    let constantToCalculateWidthButton : CGFloat = 75
    let settingsButtonWidth : CGFloat = 288
    let settingButtonHeight : CGFloat  = 54
    let textColor: UIColor = UIColor(named: "buttonColor") ?? .primary

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUpCalendar()
        view.backgroundColor = .primary
        
    }
    
    private func setupView() {
        //Buttons
        addEventButton.frame.size.width = addEventButtonWidth
        addEventButton.frame.size.height = addEventButtonHeight
        widgthConstrainButton.constant = view.frame.width/2 + constantToCalculateWidthButton
        addEventButton.tintColor = textColor

        addEventButton.setTitle("Nuevo evento", for: .normal)
        addEventButton.setImage(UIImage(named: "add"), for: .normal)
        addEventButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -70, bottom: 0, right: 0)
        guard let customFont = UIFont(name:  "Quicksand-Bold", size: 18 ) else {
            return
        }
        addEventButton.titleLabel?.font = customFont
        addEventButton.setTitleColor(.secundary, for: .normal)
        addEventButton.titleLabel?.adjustsFontForContentSizeCategory = true

        
        settingButton.tintColor = textColor
        settingButton.setTitle("", for: .normal)
        settingButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
       
        //Corner Radius
        settingButton.clipsToBounds = true
        settingButton.layer.cornerRadius = 12
        addEventButton.clipsToBounds = true
        addEventButton.layer.cornerRadius = 12
    }
    
    func setUpCalendar() {
      //  calendarView.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        calendarView.scrollDirection = .vertical
        calendarView.backgroundColor = .primary
        calendarView.appearance.calendar.delegate = self
        calendarView.pagingEnabled = false
        calendarView.delegate = self
        calendarView.dataSource = self
      //  dateFormatter.dateFormat = "dd/MM/yyyy"
        calendarView.rowHeight = 50
        calendarView.weekdayHeight = 0
        calendarView.headerHeight = 65
        calendarView.placeholderType = .none
        calendarView.allowsMultipleSelection = false
        calendarView.today = nil
        calendarView.appearance.selectionColor = .clear
    }


}

extension ViewController: FSCalendarDelegate , FSCalendarDelegateAppearance, FSCalendarDataSource {
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return textColor
    }
    
    
    
}

