//
//  ViewCryptoControllerViewModel.swift
//  CryptoScope
//
//  Created by Jacob  Loranger on 6/1/24.
//

import Foundation
import UIKit

class ViewCyrptoControllerViewModel {
    
    // MARK - Variables
    var onImageLoaded: ((UIImage?) ->Void)?
    let coin: Coin
    
    // MARK - Initilizer
    init(_ coin: Coin) {
        self.coin = coin
        self.loadImage()
    }
    
    private func loadImage() {
        let imageData = try? Data(contentsOf: self.coin.logoURL!)
        
        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
    }
    
    // MARK - Computed Properties
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.USD.price)"
    }
    
    var marketCapLabel: String {
        return "MarketCap: $\(self.coin.pricingData.USD.market_cap)"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "Max Supply: N/A"
        }
    }
}
