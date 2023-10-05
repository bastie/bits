
extension bits.de.tax {
  
  /// The german tax ID for humans.
  ///
  /// checksum algorithm can found [here](https://www.zfa.deutsche-rentenversicherung-bund.de/de/Inhalt/public/4_ID/47_Pruefziffernberechnung/001_Pruefziffernberechnung.pdf?__blob=publicationFile&v=1)
  public struct SteuerlicheIdentifikationsnummer {
    
    ///
    public static func getChecksum (steuerID : String) -> Int? {
      ///- GUARDS
      guard 10 == steuerID.count else {
        return nil
      }
      guard !steuerID.starts(with: "0") else {
        return nil
      }
      if true {
        let stringArray = steuerID.map ({String($0)})
        for index in 2 ..< stringArray.count {
          if stringArray [index - 2] == stringArray [index - 1] &&
              stringArray [index - 1] == stringArray [index] {
            return nil
          }
        }
      }
      
      ///- BUSINESS CODE
      let n = 11
      let m = 10
      var product = m;
      var sum : Int;
      
      for digit in steuerID.map({String($0)}).map({Int($0)!}) {
        sum = (digit + product) % m;
        if(sum == 0) {
          sum = m;
        }
        product = (2*sum) % n;
      }
      let checksum = n - product
      return (checksum == 10) ? 0 : checksum;
    }
  
    public static func isValid (steuerIDWithChecknumber : String) -> Bool {
      guard 11 == steuerIDWithChecknumber.count else {
        return false
      }
      if let checksum = SteuerlicheIdentifikationsnummer.getChecksum (steuerID: String( steuerIDWithChecknumber.prefix(10))) {
        if steuerIDWithChecknumber.map({String($0)}).map({Int($0)!})[10] == checksum {
          return true
        }
      }
      return false
    }
    
  } // end of type 
}
