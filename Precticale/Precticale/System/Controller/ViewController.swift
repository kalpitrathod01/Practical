//
//  ViewController.swift
//  Precticale
//
//  Created by Kalpit Rathod on 26/09/22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet var tblView: UITableView!
    
    //MARK: - var
    var arrData : [ModelData] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXIB()
    }
}

//MARK: - TableView Method

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func registerXIB(){
        self.tblView.registerCell(type: detailCell.self)
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! detailCell
        
        let dict = self.arrData[indexPath.row]
                
        if let str = dict.name , str.count > 0 {
            cell.lblTital.text = str
        } else {
            cell.lblTital.text = ""
        }
        
        if var str = dict.time , str.count > 0 {
            str = str.convertUTCToLocal()
            cell.lblTime.text = str.ChangeDateFormate(needDateFormate: DateTimeHandler.defaultFormat) + " - " + self.add15Min(str: str).ChangeDateFormate(needDateFormate: DateTimeHandler.displayTimeFormat)
        } else {
            cell.lblTime.text = ""
        }
        
        if let img = dict.imageUrl , img.count > 0{
            cell.img.loadImageURL(url: URL(string: img), placeholder: UIImage(named: "Placeholder")!)
        } else {
            cell.img.image = UIImage(named: "Placeholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - Helper Func
extension ViewController {
    func add15Min(str: String) -> String {
        let gresing15MinTimeDate = str.convertStringToDate(currnetFormate: DateTimeHandler.commonUTC)
        let gresing15MinTimeAdd = gresing15MinTimeDate.adding(minutes: 15)
        let gresing15MinTimeSTR = gresing15MinTimeAdd.dateToString(formate: DateTimeHandler.commonUTC)
        return gresing15MinTimeSTR
    }
    
    func setData() {
        if ApiUtillity.sharedInstance.isReachable() {
            self.WSGetData()
        } else {
            if let dataObj = ApiUtillity.sharedInstance.getBaseModel() {
                if dataObj.count > 0 {
                    self.arrData = dataObj
                    self.tblView.reloadData()
                } else {
                    self.displayToast(errorMessage: "First time internate Required!")
                }
            } else {
                self.displayToast(errorMessage: "First time internate Required!")
            }
            
        }
    }
}

//MARK: - Get API data
extension ViewController {
    
    func WSGetData() {
        let parameters = [String : Any]()
        APIClient<ModelBaseClass, ModelBaseClass>().API_GET(Url: "https://interview.avital.in/ios_interview.json" , Params: parameters as [String:AnyObject], Authentication: true, Progress: true, Alert: false, Offline: false, SuperVC: self) { (modelResponse) in
            
            self.arrData.removeAll()
            
            if let data = modelResponse.data , data.count > 0 {
                self.arrData = data
                self.tblView.reloadData()
                ApiUtillity.sharedInstance.setBaseModel(modelResponse: data)
            }
            
        } completionError: { (modelError,_) in
            print(modelError)
        } completionFailed: { (modelError) in
            print(modelError.localizedDescription)
        }
    }
}


