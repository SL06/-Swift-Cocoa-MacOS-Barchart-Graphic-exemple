//
//  Drawing1.swift
//  MyGraph
//
//  Created by slareau on 2022-10-17.
//

import Cocoa

class ChartsVC1: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        print("ChartsVC1")
        // create dr as NSView
        let dr = Drawing1(frame: NSRect(x: 50, y: 50, width: 550, height: 500))
        
        //ios
        //dr.backgroundColor = .blue
       // dr.alpha = 0.5
        //dr.tag = 100
        
        //add backgroundcolor to dr  - MacOS
        //dr.wantsLayer = true
        //dr.layer?.backgroundColor = NSColor.blue.cgColor
        
        self.view.addSubview(dr)
        
         
   
    }
}
    
class Drawing1: NSView {
    
    // var facts_list: [myfact] = [] //complete database
    // var fact_total: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
     var fact_total: [Double] = [12454, 22365,18989, 14656, 16777]
     
    // var comm_list: [myComm] = []
    // var comm_total: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
     var comm_total: [Double] = [8976, 14989, 13989, 12065, 15040]
    
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
        
      //  Load_CommDB()
      //  Load_FactDB()

        
        var j = 0
        while j < 5 {  // last 5 years
            print ( "VCH165:  ", Current_Year - j, fact_total[j], comm_total[j] )
            j += 1
        }
        
        
       // frame background
        myRect(x: 0, y: 0, wd: 500, ht: 400, color: NSColor.lightGray)
        
        for i in 0...4 {
            
            let factT = String(fact_total[4 - i])
            let commT = String(comm_total[4 - i])
            let diffT = String(fact_total[4 - i] - comm_total[4 - i])
            
            myRect(x: Double(50 + 80 * i) , y: 80, wd: 50, ht: Double(fact_total[4 - i]/100), color: NSColor.blue)
            myRect(x: Double(60 + 80 * i) , y: 80, wd: 50, ht: Double(comm_total[4 - i]/100), color: NSColor.orange)
            myRect(x: Double(70 + 80 * i) , y: 80, wd: 50, ht: Double((fact_total[4 - i] - comm_total[4 - i])/100), color: NSColor.green)
            
           // myRect(x: Double(50 + 80 * i) , y: 60, wd:70, ht:14, color: NSColor.white)
            mytext2(txt:  factT.toCurrencyFormat(), x: Double(45 + 80 * i), y: 60, wd: (75), ht: 14, align: .right)
            mytext2(txt:  commT.toCurrencyFormat(), x: Double(45 + 80 * i), y: 40, wd: (75), ht: 14, align: .right)
            mytext2(txt:  diffT.toCurrencyFormat(), x: Double(45 + 80 * i), y: 20, wd: (75), ht: 14, align: .right)
            mytext2(txt:  String(Current_Year - (4 - i)), x: Double(45 + 80 * i), y: 3, wd: (75), ht: 14, align: .center)
            
            /*mytext(txt:  commT.toCurrencyFormat(), x: Double(45 + 80 * i), y: 40)
            mytext(txt:  diffT.toCurrencyFormat(), x: Double(45 + 80 * i), y: 20)
            mytext(txt:  String(Current_Year - (4 - i)), x: Double(45 + 80 * i), y: 3)*/
        }
        
        let context = NSGraphicsContext.current!.cgContext;
            context.beginPath()
            context.move(to: CGPoint(x: 10.0, y: 78.0))
            context.addLine(to: CGPoint(x: 480.0, y: 78.0))
            //context.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            context.setStrokeColor(NSColor.black.cgColor)
            context.setLineWidth(2.0)
            context.strokePath()
        
       
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
        let attrs = [NSAttributedString.Key.font: NSFont(name: "Arial", size: 16)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

        //title
        let string = "Annual profit - 5 years"
            string.draw(with: CGRect(x: 20, y: 0, width: 448, height: 448), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        
     

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
        
    }*/
    
    
    
}
        
        
   

