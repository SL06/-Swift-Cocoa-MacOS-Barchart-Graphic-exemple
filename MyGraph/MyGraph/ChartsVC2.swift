//
//  Drawing1.swift
//  MyGraph
//
//  Created by slareau on 2022-10-17.
//

import Cocoa

let NSV_Height = 600
let NSV_Width = 600

class ChartsVC2: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        print("ChartsVC")
        // create dr as NSView
       // let NSV_Heigth = 600
       // let NSV_Width = 600
        
        let dr = Drawing2(frame: NSRect(x: 50, y: 50, width: NSV_Width, height: NSV_Height))
        
        
        
        //ios
        //dr.backgroundColor = .blue
       // dr.alpha = 0.5
        //dr.tag = 100
        
        //add backgroundcolor to dr  - MacOS
        dr.wantsLayer = true
        dr.layer?.backgroundColor = NSColor.lightGray.cgColor
        
        self.view.addSubview(dr)
        
         
   
    }
}
    
class Drawing2: NSView {   // sale for 12 month, last 2 years
    
   // var facts_list: [myfact] = [] //complete database
   // var fact_total: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
    var fact_total: [[Double]] =
        [
            [1900, 1560, 798, 456, 1476, 1367, 1866, 1346, 3346, 1256, 3768, 3455 ],
            [1567, 1657, 1268, 1473, 1789, 1245, 1567, 2286, 3222, 2345, 1876, 2848 ]
        ]
   // var comm_list: [myComm] = []
   // var comm_total: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
   /* var comm_total: [[Double]] =
    [
        [900, 560, 248, 456, 987 , 367, 866, 346, 2346, 256, 6768, 2455 ],
        [567, 657, 568, 473, 789 , 245, 567, 1986, 2222, 345, 876, 1483 ]
    ]*/
    var Current_Year : Int = 0
    var Current_Month : Int = 0

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        
        let todays_date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        Current_Year = Int(dateFormatter.string(from: todays_date))!
        
       // print ("VC60:", dateFormatter.string(from: todays_date), Current_Year!) OK
        
        
        dateFormatter.dateFormat = "MM"
        Current_Month = Int(dateFormatter.string(from: todays_date))!
        
        let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale(identifier: "fr-CA")

        

        //for i in 0...1 {  // 2 years
            for j in 0...11 {  // 12 month
            
      
                
            var sale = (fact_total[0][j])
            myRect(x: Double(65 + 40 * j) , y: Double(50), wd: 20, ht: (sale/10), color: NSColor.blue)
                
            sale = (fact_total[1][j])
                myRect(x: Double(70 + 40 * j) , y: Double(50), wd: 20, ht: (sale/10), color: NSColor.green)
                
            
           var month = Current_Month + j
           if (month > 11) {month = month - 12}
   
           mytext2(txt:  DateFormatter().shortMonthSymbols[month].capitalized, x: Double(40 + 40 * j), y: 20, wd: (75), ht: 14, align: .center)
                
            //   print ( DateFormatter().monthSymbols[month].capitalized )
            
            
            
           // myRect(x: Double(50 + 80 * i) , y: 60, wd:70, ht:14, color: NSColor.white)
          /*  mytext2(txt:  sale.toCurrencyFormat(), x: Double(45 + 80 * j), y: 60, wd: (75), ht: 14, align: .right)
            mytext2(txt:  purchase.toCurrencyFormat(), x: Double(45 + 80 * j), y: 40, wd: (75), ht: 14, align: .right)
            mytext2(txt:  diff.toCurrencyFormat(), x: Double(45 + 80 * j), y: 20, wd: (75), ht: 14, align: .right)*/
          //  mytext2(txt:  String(Current_Year - (i)), x: Double(45 + 80 * j), y: 3, wd: (75), ht: 14, align: .center)
            
            /*mytext(txt:  commT.toCurrencyFormat(), x: Double(45 + 80 * i), y: 40)
            mytext(txt:  diffT.toCurrencyFormat(), x: Double(45 + 80 * i), y: 20)
            mytext(txt:  String(Current_Year - (4 - i)), x: Double(45 + 80 * i), y: 3)*/
        }
        
        let context = NSGraphicsContext.current!.cgContext;
            context.beginPath()
            context.move(to: CGPoint(x: 50.0, y: 40.0))
            context.addLine(to: CGPoint(x: 550.0, y: 40.0))
            //context.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            context.setStrokeColor(NSColor.black.cgColor)
            context.setLineWidth(2.0)
            context.strokePath()
        
       
        // put title in box and centered
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
        let attrs = [NSAttributedString.Key.font: NSFont(name: "Arial", size: 16)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let string = "Sale per month  - last 2 years"
            string.draw(with: CGRect(x: 20, y: 0, width: NSV_Width, height: (NSV_Height - 50) ), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        //print ((NSV_Height - 50))
     

    }
    
    func myRect( x: Double, y: Double, wd:  Double, ht :Double, color: NSColor) {
        let context = NSGraphicsContext.current!.cgContext;
        let rectangle = CGRect(x: x, y: y, width: wd, height: ht) // NSRect or CGRect work
        //context.setFillColor(NSColor.yellow.cgColor)
        context.setFillColor(color.cgColor)
        context.setStrokeColor(NSColor.black.cgColor)
        context.setLineWidth(2)
        context.addRect(rectangle)
        context.drawPath(using: .fillStroke)
        
    
    }
    
    func mytext ( txt: String,  x: Double, y: Double) {
        // let myfont = CTFontCreateWithName("Papyrus" as CFString, 12, nil)
        
        //let rectangle = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        let myfont = CTFontCreateWithName("Arial" as CFString, 12, nil)
        let attributedString = NSAttributedString(string: txt, attributes: [NSAttributedString.Key.font: myfont])
        //  let attributedString = NSAttributedString(string: "allo le monde")
        let line = CTLineCreateWithAttributedString(attributedString)
        
        // Draw text
        if let context = NSGraphicsContext.current?.cgContext {
            context.textPosition = .init(x: x , y: y)
            CTLineDraw(line, context)
        }
        //https://blog.krzyzanowskim.com/2020/07/09/coretext-academy-part-1/
        //https://blog.krzyzanowskim.com/2020/07/10/coretext-swift-academy-part-2/
        //https://blog.krzyzanowskim.com/2020/07/13/coretext-swift-academy-part-3/
    }
    
    func mytext2 ( txt: String,  x: Double, y: Double, wd: Double ,  ht: Double, align: NSTextAlignment) {
   // func mytext2 ( txt: String,  x: Double, y: Double, wd: Double ,  ht: Double, align: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = align
        
      /*  if align == "R" { paragraphStyle.alignment = .right}
        else if align == "L" { paragraphStyle.alignment = .left}
        else if align == "C" { paragraphStyle.alignment = .center}*/
        
        let attrs = [NSAttributedString.Key.font: NSFont(name: "Arial", size: 12)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let string = txt
            string.draw(with: CGRect(x: x, y: y, width: wd, height: ht), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
    
 /*
    func Load_FactDB() {
        
        let factDB = DBH.readFactDB()
        var record: [String] = []
        var i = 0
        
        
      // print( "VC139:", factDB.count)  // factDB.count  = 622
    
   
        while i < factDB.count {
            record = factDB[i]
            
            
            facts_list.append(myfact( record[0], record[1], record[2], record[3], record[4], record[5], record[6], record[7], record[8], Double(record[9]) ?? 0, Double(record[10]) ?? 0, Double(record[11]) ?? 0, Double(record[12]) ?? 0, Double(record[13]) ?? 0, Double(record[14]) ?? 0 , Double(record[15]) ?? 0, record[16], record[17], record[18] ))
            
            var j = 0
            while j < 5 {  // last 5 years
              //  print( "VC148:", i, j, Current_Year - j, facts_list[i].date_f, facts_list[i].date_f.contains(String(Current_Year - j)))
                if facts_list[i].date_f.contains(String(Current_Year - j)) {
                    // print( "VC148:",Current_Year - j, i , j, fact_total[j])
                    fact_total[j] += facts_list[i].montant_total
                }
                j += 1
            }
            
            
            i += 1
        }  //while i < factDB.count
    }
        
    func Load_CommDB() {
        
        var record: [String] = []
        var i = 0
        
        
        let commDB = DBH.readCommDB()
        
        while i < commDB.count {
            record = commDB[i]
            
            //String, String, String, String, String, String, String, Double, Double, Double, Double, Double, Double, Double, String
            
            comm_list.append(myComm( record[0], record[1], record[2], record[3], record[4], record[5], record[6], Double(record[7]) ?? 0, Double(record[8]) ?? 0, Double(record[9]) ?? 0, Double(record[10]) ?? 0, Double(record[11]) ?? 0, Double(record[12]) ?? 0, Double(record[13]) ?? 0, record[14], record[15], record[16] ))
            
            var j = 0
            while j < 5 {  // last 5 years
              //  print( "VC148:", i, j, Current_Year - j, facts_list[i].date_f, facts_list[i].date_f.contains(String(Current_Year - j)))
                if comm_list[i].date_facture.contains(String(Current_Year - j)) {
                    // print( "VC148:",Current_Year - j, i , j, fact_total[j])
                     comm_total[j] += comm_list[i].montant_total
                }
                j += 1
            }
           // comm_total += comm_list[i].montant_total
            
            i += 1
        }  //while i < factDB.count
  */
        
    }
   
    
    

        
        
   

