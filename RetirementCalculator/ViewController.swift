//
//  ViewController.swift
//  RetirementCalculator
//
//  Created by Pamela Audi on 11/02/2020.
//  Copyright © 2020 Pamela Audi. All rights reserved.
//

import Cocoa
import Charts

class ViewController: NSViewController {
    
    // variable declarations
    
    var UserID = ""
    var nestEgg: Double = 0.00
    var nestEggInc: Double = 0.00
    var salary: Double = 0.00
    var salaryInc: Double = 0.00
    var yearlyAdd: Double = 0.00
    var UserAge: Double = 0.00
    var RetirementAge: Double = 0.00
    var SlowDownAge: Double = 0.00
    var LifeExp: Double = 0.00
    var ActiveYrsIncome: Double = 0.00
    var InactiveYrsIncome: Double = 0.00
    var ActiveArr: [Double] = []
    var InactiveArr: [Double] = []
    var TableData = [[Double]]()
    var LumpSum: Double = 0.00
    var points = [ChartDataEntry]()
    var linedata: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // preload value here into the textfields.
        
        UserName.stringValue = "Valentine Audi"
        Nest.doubleValue = 150000.00
        NestEggInc.doubleValue = 7.00
        Sal.doubleValue = 50000.00
        SalaryInc.doubleValue = 2.00
        YearlyContrib.doubleValue = 10.00
        Age.doubleValue = 25
        RetireAge.doubleValue = 62
        slowDownAge.doubleValue = 82
        LifeExpectancy.doubleValue = 101
        ActiveYears.doubleValue = 200000.00
        InactiveYears.doubleValue = 200000.00
        
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var TotalReceived: NSTextField!
    
    @IBOutlet weak var TotalNest: NSTextField!
    
    @IBOutlet weak var LineChartView: LineChartView!
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var UserName: NSTextField!
    
    @IBOutlet weak var Sal: NSTextField!
    
    @IBOutlet weak var SalaryInc: NSTextField!
    
    @IBOutlet weak var Nest: NSTextField!
    
    @IBOutlet weak var NestEggInc: NSTextField!
    
    @IBOutlet weak var YearlyContrib: NSTextField!
    
    @IBOutlet weak var Age: NSTextField!
    
    @IBOutlet weak var RetireAge: NSTextField!
    
    @IBOutlet weak var slowDownAge: NSTextField!
    
    @IBOutlet weak var LifeExpectancy: NSTextField!
    
    @IBOutlet weak var ActiveYears: NSTextField!
    
    @IBOutlet weak var InactiveYears: NSTextField!
    
    @IBAction func Compute(_ sender: Any) {
        
        // Take data from the textfields if user enters them
        
        self.UserID = UserName.stringValue
        self.nestEgg = Nest.doubleValue
        self.nestEggInc = NestEggInc.doubleValue
        self.salary = Sal.doubleValue
        self.salaryInc = SalaryInc.doubleValue
        self.yearlyAdd = YearlyContrib.doubleValue
        self.UserAge = Age.doubleValue
        self.RetirementAge = RetireAge.doubleValue
        self.SlowDownAge = slowDownAge.doubleValue
        self.LifeExp = LifeExpectancy.doubleValue
        self.ActiveYrsIncome = ActiveYears.doubleValue
        self.InactiveYrsIncome = InactiveYears.doubleValue
        
        
        // Main function
        self.LumpSum = NestEgg()
        self.TableData = RetireTable()
        self.tableView.reloadData()
        self.Chart()
        
        // Check operation of code
        print("The final Amount is: ", LumpSum)
        print ("Behold the Table array: ", TableData)
        print ("Behold the Plot Points: ", points)
    }
    
    
    @IBAction func Compare(_ sender: Any) {
        
        // Re-initialize variable with zeros
        self.UserID = ""
        self.nestEgg = 0.00
        self.nestEggInc = 0.00
        self.salary = 0.00
        self.salaryInc = 0.00
        self.yearlyAdd = 0.00
        self.UserAge = 0.00
        self.RetirementAge = 0.00
        self.SlowDownAge = 0.00
        self.LifeExp = 0.00
        self.ActiveYrsIncome = 0.00
        self.InactiveYrsIncome = 0.00
        self.TableData = [[Double]]()
        self.LumpSum = 0.00
        // self.points = [ChartDataEntry]()
        // self.linedata = []
        
        // Take new data from text fields
        self.UserID = UserName.stringValue
        self.nestEgg = Nest.doubleValue
        self.nestEggInc = NestEggInc.doubleValue
        self.salary = Sal.doubleValue
        self.salaryInc = SalaryInc.doubleValue
        self.yearlyAdd = YearlyContrib.doubleValue
        self.UserAge = Age.doubleValue
        self.RetirementAge = RetireAge.doubleValue
        self.SlowDownAge = slowDownAge.doubleValue
        self.LifeExp = LifeExpectancy.doubleValue
        self.ActiveYrsIncome = ActiveYears.doubleValue
        self.InactiveYrsIncome = InactiveYears.doubleValue
        
        // Rework the program
        self.LumpSum = NestEgg()
        self.TableData = RetireTable()
        self.tableView.reloadData()
        self.Chart()
    }
    
    // All the code functions used in the program are located underneath
    
    //The Nest Egg Tracking Function
        func NestEgg() -> Double {
        var WorkingYrs = self.RetirementAge - self.UserAge
        var Remainder: Double = 0.00
        var interest: Double = 0.00
        var Withdrawal: Double = 0.00
        var yearlyContrib: Double = 0.00
        var EndingBalance: Double = 0.00
        var AgeCount = self.UserAge
        let date = Date()
        let calendar = Calendar.current
        let TodayYr = calendar.component(.year, from: date)
        var myTdy = Double(TodayYr)
        var z = [Double]()
        interest = (nestEgg * (nestEggInc/100))
        Remainder = nestEgg - Withdrawal
        yearlyContrib = ((yearlyAdd/100) * salary)
        EndingBalance = Remainder + interest + yearlyContrib
        
        repeat {
            z = [myTdy, AgeCount, salary.roundToPlaces(places: 2), yearlyContrib.roundToPlaces(places: 2), nestEgg.roundToPlaces(places: 2), Withdrawal.roundToPlaces(places: 2), Remainder.roundToPlaces(places: 2), interest.roundToPlaces(places: 2), EndingBalance.roundToPlaces(places: 2)]
            TableData.append(z)
            points.append(ChartDataEntry(x: AgeCount, y: nestEgg.roundToPlaces(places: 2)))
            
            WorkingYrs -= 1
            AgeCount += 1
            myTdy += 1
            
            salary = salary + (salary * (salaryInc/100))
            yearlyContrib = ((yearlyAdd/100) * salary)
            nestEgg = EndingBalance
            interest = (nestEgg * (nestEggInc/100))
            Remainder = nestEgg - Withdrawal
            EndingBalance = Remainder + interest + yearlyContrib
            
        } while WorkingYrs > 0
        // nestEgg = nestEgg + interest
        TotalNest.doubleValue = nestEgg.roundToPlaces(places: 2)
        return nestEgg
    }
    
    // The retirement table data Tracking function
    func RetireTable() -> [[Double]]{
        var Remainder: Double = 0.00
        var interest: Double = 0.00
        var RetireYrs = LifeExp - RetirementAge
        var AgeCount = RetirementAge
        salary = 0.00
        yearlyAdd = 0.00
        var TotalRecv: Double = 0.00
        var EndingBalance: Double = 0.00
        let SlowDownCount = SlowDownAge - RetirementAge
        let date = Date()
        let calendar = Calendar.current
        let TodayYr = calendar.component(.year, from: date)
        var myTdy = Double(TodayYr)
        var z = [Double]()
        repeat {
            if RetireYrs > SlowDownCount {
                if nestEgg > ActiveYrsIncome {
                    Remainder = nestEgg - ActiveYrsIncome
                    let Withdrawal = ActiveYrsIncome
                    interest = Remainder * (nestEggInc/100)
                    EndingBalance = Remainder + interest
                    z = [myTdy, AgeCount, salary.roundToPlaces(places: 2), yearlyAdd.roundToPlaces(places: 2), nestEgg.roundToPlaces(places: 2), Withdrawal.roundToPlaces(places: 2), Remainder.roundToPlaces(places: 2), interest.roundToPlaces(places: 2), EndingBalance.roundToPlaces(places: 2)]
                    TableData.append(z)
                    points.append(ChartDataEntry(x: AgeCount, y: nestEgg.roundToPlaces(places: 2)))
                    nestEgg = Remainder + interest
                    TotalRecv += Withdrawal
                } else if nestEgg < ActiveYrsIncome {
                    Remainder = nestEgg - nestEgg
                    interest = Remainder * (nestEggInc/100)
                    EndingBalance = Remainder + interest
                    z = [myTdy, AgeCount, salary.roundToPlaces(places: 2), yearlyAdd.roundToPlaces(places: 2), nestEgg.roundToPlaces(places: 2), nestEgg.roundToPlaces(places: 2), Remainder.roundToPlaces(places: 2), interest.roundToPlaces(places: 2), EndingBalance.roundToPlaces(places: 2)]
                    TableData.append(z)
                    points.append(ChartDataEntry(x: AgeCount, y: nestEgg))
                    TotalRecv += nestEgg
                    break
                }
            }
            else if RetireYrs > 0 {
                if nestEgg > InactiveYrsIncome {
                    Remainder = nestEgg - InactiveYrsIncome
                    let Withdrawal = InactiveYrsIncome
                    interest = Remainder * (nestEggInc/100)
                    EndingBalance = Remainder + interest
                    z = [myTdy, AgeCount, salary.roundToPlaces(places: 2), yearlyAdd.roundToPlaces(places: 2), nestEgg.roundToPlaces(places: 2), Withdrawal.roundToPlaces(places: 2), Remainder.roundToPlaces(places: 2), interest.roundToPlaces(places: 2), EndingBalance.roundToPlaces(places: 2)]
                    TableData.append(z)
                    nestEgg = Remainder + interest
                    points.append(ChartDataEntry(x: AgeCount, y: nestEgg.roundToPlaces(places: 2))) // remember this to confirm
                    TotalRecv += Withdrawal
                } else if nestEgg < InactiveYrsIncome {
                    Remainder = nestEgg - nestEgg
                    interest = Remainder * (nestEggInc/100)
                    EndingBalance = Remainder + interest
                   z = [myTdy, AgeCount, salary.roundToPlaces(places: 2), yearlyAdd.roundToPlaces(places: 2), nestEgg.roundToPlaces(places: 2), nestEgg.roundToPlaces(places: 2), Remainder.roundToPlaces(places: 2), interest.roundToPlaces(places: 2), EndingBalance.roundToPlaces(places: 2)]
                    TableData.append(z)
                    points.append(ChartDataEntry(x: AgeCount, y: nestEgg.roundToPlaces(places: 2)))
                    TotalRecv += nestEgg
                    break
                }
            }
        RetireYrs -= 1
        AgeCount += 1
        myTdy += 1
        } while RetireYrs > -1 && nestEgg > 0
        TotalReceived.doubleValue = TotalRecv.roundToPlaces(places: 2)
        return TableData
    }
    
    // The "draw-chart" function
    func Chart(){
        let data = LineChartData()
        let ChartPoints = LineChartDataSet(entries: points, label: "Nest Egg")
        ChartPoints.colors = [NSUIColor.red]
        ChartPoints.drawCirclesEnabled = false
        ChartPoints.drawCircleHoleEnabled = false
        ChartPoints.drawValuesEnabled = false
        data.addDataSet(ChartPoints)
        self.LineChartView.data = data
        self.LineChartView.gridBackgroundColor = NSUIColor.white
        self.LineChartView.chartDescription?.text = "A Line Chart of Nest Egg Amount over the Years "
    }
    
}

extension ViewController: NSTableViewDataSource {
        
        func numberOfRows(in tableView: NSTableView) -> Int {
            return TableData.count
        }

      }

extension ViewController: NSTableViewDelegate {

  fileprivate enum CellIdentifiers {
    static let YearCell = "YearID"
    static let AgeCell = "AgeID"
    static let SavingsAmCell = "SavingsAmID"
    static let WithdrawalCell = "WithdrawalID"
    static let SavingsRemCell = "SavingsRemID"
    static let InterestCell = "InterestID"
    static let ContribCell = "ContribID"
    static let SalaryCell = "SalaryID"
    static let EndingBalCell = "EndingBalanceID"
  }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: Double = 0.00
        var cellIdentifier: String = ""
        var data = [Double]()
        data = self.TableData[row]

        if tableColumn == tableView.tableColumns[0] {
            text = data[0]
            cellIdentifier = CellIdentifiers.YearCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = data[1]
            cellIdentifier = CellIdentifiers.AgeCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = data[2]
            cellIdentifier = CellIdentifiers.SalaryCell
        } else if tableColumn == tableView.tableColumns[3] {
            text = data[3]
            cellIdentifier = CellIdentifiers.ContribCell
        } else if tableColumn == tableView.tableColumns[4] {
            text = data[4]
            cellIdentifier = CellIdentifiers.SavingsAmCell
        } else if tableColumn == tableView.tableColumns[5] {
            text = data[5]
            cellIdentifier = CellIdentifiers.WithdrawalCell
        } else if tableColumn == tableView.tableColumns[6] {
            text = data[6]
            cellIdentifier = CellIdentifiers.SavingsRemCell
        } else if tableColumn == tableView.tableColumns[7] {
            text = data[7]
            cellIdentifier = CellIdentifiers.InterestCell
        }  else if tableColumn == tableView.tableColumns[8] {
                   text = data[8]
                   cellIdentifier = CellIdentifiers.EndingBalCell
               }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.doubleValue = text
            return cell
        }
    return nil
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
