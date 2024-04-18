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
    let currentCalendar = Calendar.current
    let dateLabel = UILabel()
    let dateFormatter = DateFormatter()
    var events: [(Date, Event)] = []
    let currentDate = Date()
    let generator = UISelectionFeedbackGenerator()
    let preferencesManager = PreferencesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUpCalendar()
        
        //Config
        preferencesManager.saveVibrationEnabled(true)
        preferencesManager.saveAnimationSelectDayEnabled(true)
    }
    
    
    
    
    private func setupView() {
        //ToolBar
        view.backgroundColor = .primary
        self.navigationController!.navigationBar.barTintColor = .primary
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.font:  UIFont(name: "Quicksand-SemiBold", size: 18) ?? .systemFont(ofSize: 18)]
        let calendarButton = UIBarButtonItem(image: UIImage(named: "todayBtn"), style: .plain, target: self, action: #selector(goToCurrentDate))
        self.navigationItem.rightBarButtonItem = calendarButton
        //Buttons
        addEventButton.frame.size.width = addEventButtonWidth
        addEventButton.frame.size.height = addEventButtonHeight
        widgthConstrainButton.constant = view.frame.width/2 + constantToCalculateWidthButton
        addEventButton.tintColor = textColor
        
        addEventButton.setTitle("New event", for: .normal)
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
    
    
    @IBAction func goToAddEventVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addEventVC = storyboard.instantiateViewController(withIdentifier: "AddEventViewController") as? AddEventViewController {
            present(addEventVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func goToCurrentDate() {
        calendarView.select(currentDate, scrollToDate: false)
        calendarView.setCurrentPage(currentDate, animated: true)
        self.calendarView.reloadData()
    }
    
    func setUpCalendar() {
        calendarView.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        calendarView.scrollDirection = .vertical
        calendarView.backgroundColor = .primary
        calendarView.appearance.calendar.delegate = self
        calendarView.pagingEnabled = false
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.headerTitleColor = .button
        calendarView.appearance.titleSelectionColor = .primary
        calendarView.appearance.headerTitleFont = UIFont(name: "Quicksand-Bold", size: 20)
        calendarView.appearance.titleFont = UIFont(name: "Quicksand-SemiBold", size: 16)
        
        //  dateFormatter.dateFormat = "dd/MM/yyyy"
        calendarView.rowHeight = 50
        calendarView.weekdayHeight = 0
        calendarView.headerHeight = 65
        calendarView.placeholderType = .none
        calendarView.allowsMultipleSelection = false
        calendarView.today = nil
        calendarView.appearance.selectionColor = .clear
        calendarView.appearance.headerSeparatorColor = .clear
    }
    
    
}

extension ViewController: FSCalendarDelegate , FSCalendarDelegateAppearance, FSCalendarDataSource {
    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let calendarCell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        calendarCell.cellBackgroundColor = .primary
        return calendarCell
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return textColor
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if preferencesManager.isVibrationEnabled() {
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
        //   let events = events.filter({$0.0 == date})
        let currentCalendar = Calendar.current
        let dayOfMonth = currentCalendar.component(.day, from: date)
        calendar.select(date, scrollToDate: true)
        if let cell = calendar.cell(for: date, at: monthPosition) {
            updateSelectedDateAppearance(cell: cell, date: date, isSelected: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let cell = calendar.cell(for: date, at: monthPosition) {
            cell.cellBackgroundColor = .primary
            updateSelectedDateAppearance(cell: cell, date: date, isSelected: false)
        }
    }
    
    private func updateSelectedDateAppearance(cell: FSCalendarCell, date: Date, isSelected: Bool) {
        cell.backgroundColor = .clear
        let currentDate = Date()
        
        if currentCalendar.isDate(date, inSameDayAs: currentDate) {
            cell.layer.cornerRadius =  8
            cell.layer.masksToBounds = true
            cell.cellBackgroundColor = .systemPink
        }
        
        if cell.isSelected {
            cell.layer.cornerRadius =  8
            cell.layer.masksToBounds = true
            cell.cellBackgroundColor =  .button
        }
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        updateSelectedDateAppearance(cell: cell, date: date, isSelected: cell.isSelected)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        guard let cell = calendar.cell(for: date, at: monthPosition) else { return true }
        if !preferencesManager.isAnimationSelectDayEnabled() {return true}
        // Comienza con un tamaño más pequeño
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            // Realiza la animación de selección aquí
            cell.transform = CGAffineTransform.identity // Restaura el tamaño original
        }, completion: nil)
        
        return true
        
    }
    
    
}


