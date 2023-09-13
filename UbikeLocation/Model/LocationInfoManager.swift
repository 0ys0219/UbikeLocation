//
//  LocationInfoManager.swift
//  UbikeLocation
//
//  Created by 林育生 on 2023/9/13.
//

import Foundation

struct LocationInfoManager {
    let url = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json"
    
    var delegate: LocationInfoDelegate?
    
    
    
    func fetchLocationInfo() {
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let e = error {
                print(e)
            }
            guard let safeData = data else { return }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode([LocationInfoData].self, from: safeData)
                delegate?.saveLocationInfo(from: results)
            } catch {
                print("Json有問題 \(error)")
            }
            
        }
        task.resume()
    }
    

    
}
protocol LocationInfoDelegate {
    func saveLocationInfo(from results: [LocationInfoData])
}
