import XCTest
@testable import bits

final class SteuerlicheIdentifikationsnummerTests: XCTestCase {
  
  func testCorrectChecksum() throws {
    XCTAssertEqual(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "8609574271") , 9)
    XCTAssertEqual(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "4703689281") , 6)
    XCTAssertEqual(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "6592997048") , 9)
    XCTAssertEqual(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "5754928501") , 7)
    XCTAssertEqual(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "2576813141") , 1)
  }
  
  func testInCorrectChecksum () throws {
    // to short
    XCTAssertNil(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "860957427"),"SteuerID: to short not detected")
    // to long
    XCTAssertNil(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "86095742719"),"SteuerID: to longnot detected")
    // starts with zero
    XCTAssertNil(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "0609574271"),"SteuerID: leading zero not detected")
    XCTAssertNil(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "0A09574271"),"SteuerID: non digit character not detected")
    XCTAssertNil(bits.de.tax.SteuerlicheIdentifikationsnummer.getChecksum(steuerID: "8609574441"),"SteuerID: three same digits in a row not detected")
  }
  
  
  func testIsValid () throws {
    // to short
    XCTAssertFalse(bits.de.tax.SteuerlicheIdentifikationsnummer.isValid(steuerIDWithChecknumber: "8609574271"),"SteuerID: to short not detected")
    // to long
    XCTAssertFalse(bits.de.tax.SteuerlicheIdentifikationsnummer.isValid(steuerIDWithChecknumber: "860957427199"),"SteuerID: to long not detected")
    // false checksum
    XCTAssertFalse(bits.de.tax.SteuerlicheIdentifikationsnummer.isValid(steuerIDWithChecknumber: "86095742710"),"SteuerID: false checksum not detected")
    XCTAssertTrue(bits.de.tax.SteuerlicheIdentifikationsnummer.isValid(steuerIDWithChecknumber: "86095742719"),"SteuerID: correct checksum not detected")
  }
}
