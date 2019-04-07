//
//  MenuController.swift
//  Ucello
//
//  Created by Ian Regino on 4/7/19.
//  Copyright © 2019 Ian Regino. All rights reserved.
//

import Foundation

class MenuController {
    let baseURL = URL(string: "http://localhost:8090/")!
    
    // GET all menu categories from server
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
                let categories = jsonDictionary["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }.resume()
        
    } //end fetchCategories()
    
    
    // GET all menu items per category from server
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }.resume()
        
    } //end fetchMenuItems()
    
    
    // POST order to server
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }.resume()
        
    } //end submitOrder()
    
}
