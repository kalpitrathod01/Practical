//
//  Extension.swift
//  Precticale
//
//  Created by Kalpit Rathod on 26/09/22.
//

import Foundation
import UIKit
import Kingfisher

extension UIViewController {
    func displayErrorAlert(errorMessage: String)
    {
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            errorAlert.addAction(okAction)
            self.present(errorAlert, animated: true)
        }
    }
    
    func displayToast(errorMessage: String)
    {
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: .alert)
            self.present(errorAlert, animated: true)
        }
    }
}

//MARK:- UITableView
public extension UITableView {
    
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

//MARK:- API Response Status Code
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

//MARK:- Load Image
extension UIImageView {
    func loadImageURL(url:URL?, placeholder:UIImage) {
        guard let url = url else {return}
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(1))])
    }
}

//MARK:- String
extension String {
    func ChangeDateFormate(Currentformate: String = DateTimeHandler.commonUTC, needDateFormate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Currentformate
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = needDateFormate
        
        if let dt = date{
            return  dateFormatter.string(from: dt)
        }else{
            return ""
        }
    }
    
    func convertTimeUTCToLocal() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = DateTimeHandler.commonUTC
        let convertedDate = formatter.date(from: self)
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)
    }
    
    func convertStringToDate(currnetFormate: String) -> Date {
        let format = DateFormatter()
        format.dateFormat = currnetFormate
        if let dt: Date = format.date(from: self){
            return dt
        }else{
            return Date()
        }
    }
    
    func getDateFromStringNew(inputFormat: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = inputFormat
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self) ?? Date()
    }
    
    func convertUTCToLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeHandler.commonUTC
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        
        let timeUTC = dateFormatter.date(from: self)
        if timeUTC != nil {
            dateFormatter.timeZone = NSTimeZone.local
            let localTime = dateFormatter.string(from: timeUTC!)
            return localTime
        }
        
        return ""
    }
}

//MARK:- Date
extension Date {
    
    func dateToString(formate : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let str = dateFormatter.string(from: self)
        return str
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
