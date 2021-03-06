//
//  Xendit.swift
//  Xendit
//
//  Created by Maxim Bolotov on 3/15/17.
//
//

import Foundation
import CardinalMobile


@objcMembers
@objc(Xendit) open class Xendit: NSObject {
    
    // MARK: - Public methods
    
    // Publishable key
    public static var publishableKey: String?
    
    private static var cardinalSession: CardinalSession!
    private static var isSetup = false
    
    // Create token method with billing details and customer object
    public static func createToken(fromViewController: UIViewController, tokenizationRequest: XenditTokenizationRequest, onBehalfOf: String, completion:@escaping (_ : XenditCCToken?, _ : XenditError?) -> Void) {
        XDTCards.setup(publishableKey: publishableKey!)
        XDTCards.createToken(fromViewController: fromViewController, tokenizationRequest: tokenizationRequest, onBehalfOf: onBehalfOf, completion: completion)
    }
    
    // Create token method
    public static func createToken(fromViewController: UIViewController, cardData: CardData!, shouldAuthenticate: Bool, onBehalfOf: String, completion:@escaping (_ : XenditCCToken?, _ : XenditError?) -> Void) {
        XDTCards.setup(publishableKey: publishableKey!)
        let tokenizationRequest = XenditTokenizationRequest(cardData: cardData, shouldAuthenticate: shouldAuthenticate)
        XDTCards.createToken(fromViewController: fromViewController, tokenizationRequest: tokenizationRequest, onBehalfOf: onBehalfOf, completion: completion)
    }
    
    public static func createToken(fromViewController: UIViewController, cardData: CardData!, completion:@escaping (_ : XenditCCToken?, _ : XenditError?) -> Void) {
        XDTCards.setup(publishableKey: publishableKey!)
        let tokenizationRequest = XenditTokenizationRequest(cardData: cardData, shouldAuthenticate: true)
        XDTCards.createToken(fromViewController: fromViewController, tokenizationRequest: tokenizationRequest, onBehalfOf: nil, completion: completion)
    }
    
    public static func createToken(fromViewController: UIViewController, cardData: CardData!, shouldAuthenticate: Bool!, completion:@escaping (_ : XenditCCToken?, _ : XenditError?) -> Void) {
        XDTCards.setup(publishableKey: publishableKey!)
        let tokenizationRequest = XenditTokenizationRequest(cardData: cardData, shouldAuthenticate: shouldAuthenticate)
        XDTCards.createToken(fromViewController: fromViewController, tokenizationRequest: tokenizationRequest, onBehalfOf: nil, completion: completion)
    }
    
    // 3DS Authentication method
    // @param fromViewController The UIViewController from which will be present webview for 3DS Authentication
    // @param tokenId The credit card token id
    // @param amount The transaction amount
    public static func createAuthentication(fromViewController: UIViewController, tokenId: String, amount: NSNumber, onBehalfOf: String, completion:@escaping (_ : XenditAuthentication?, _ : XenditError?) -> Void) {
        XDTCards.setup(publishableKey: publishableKey!)
        XDTCards.createAuthentication(fromViewController: fromViewController, tokenId: tokenId, amount: amount, onBehalfOf: onBehalfOf, customer: nil, completion: completion)
    }
    
    public static func createAuthentication(fromViewController: UIViewController, tokenId: String, amount: NSNumber, completion:@escaping (_ : XenditAuthentication?, _ : XenditError?) -> Void) {
        XDTCards.setup(publishableKey: publishableKey!)
        self.createAuthentication(fromViewController: fromViewController, tokenId: tokenId, amount: amount, onBehalfOf: "", completion: completion)
    }
    
    // 3DS Authentication method
    // @param fromViewController The UIViewController from which will be present webview for 3DS Authentication
    // @param tokenId The credit card token id
    // @param amount The transaction amount
    // @param cardCVN The credit card CVN code for create token
    @available(*, deprecated:1.1, message:"cvn no longer used")
    public static func createAuthentication(fromViewController: UIViewController, tokenId: String, amount: NSNumber, cardCVN: String, completion:@escaping (_ : XenditAuthentication?, _ : XenditError?) -> Void) {
        self.createAuthentication(fromViewController: fromViewController, tokenId: tokenId, amount: amount, completion: completion)
    }

    
    // Card data validation method
    public static func isCardNumberValid(cardNumber: String) -> Bool {
        return CreditCard.isValidCardNumber(cardNumber: cardNumber)
    }
    
    // Card expiration date validation method
    public static func isExpiryValid(cardExpirationMonth: String, cardExpirationYear: String) -> Bool {
        return CreditCard.isExpiryValid(cardExpirationMonth: cardExpirationMonth, cardExpirationYear: cardExpirationYear)
    }
    
    // Card cvn validation method
    public static func isCvnValid(creditCardCVN: String) -> Bool {
        return CreditCard.isCvnValid(creditCardCVN: creditCardCVN)
    }
    
    // Card cvn validation for card type method
    public static func isCvnValidForCardType(creditCardCVN: String, cardNumber: String) -> Bool {
        return CreditCard.isCvnValidForCardType(creditCardCVN: creditCardCVN, cardNumber: cardNumber)
    }
    
    // MARK: - Logging
    public static func setLogLevel(_ level: XenditLogLevel?) {
        Log.shared.level = level
    }
    
    public static func setLogDNALevel(_ level: ISHLogDNALevel?) {
        Log.shared.logDNALevel = level
    }
}
