//
//  ViewController.swift
//  testApi
//
//  Created by hafied Khalifatul ash.shiddiqi on 22/05/21.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://localhost:8000/api/products"
        getData(from: url)
        
    	
    }
    
    private func getData(from url: String) {
        
       let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("somting went wrong")
                return
            }
            
            //hava data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("failed to convert")
            }
            
            guard let json = result else {
                return
            }
        
        print(json.status)
        print(json.result?.description)
       })
        task.resume()
    }

}

//struct Response: Decodable {
//    let results: MyResult
//    let status: String
//
//}
//
//struct MyResult: Decodable {
//    let price: Int
//}
struct Response: Codable {
    let status: String
    let result: [MyResult]?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case result
    }
}

struct MyResult: Codable {
    let id: Int?
    let name: String?
    let price: Int?
    let quantity: Int?
    let active: Int?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case quantity
        case active
        case description
        
    }
}


//struct MyResult: Codable {
//    let sunrise: String
//    let sunset: String
//    let solar_noon: String
//    let day_length: Int
//    let civil_twilight_begin: String
//    let civil_twilight_end: String
//    let nautical_twilight_begin: String
//    let nautical_twilight_end: String
//    let astronomical_twilight_begin: String
//    let astronomical_twilight_end: String
//}


//    "results": {
//        "sunrise": "1970-01-01T00:00:01+00:00",
//        "sunset": "1970-01-01T00:00:01+00:00",
//        "solar_noon": "2020-01-01T09:23:30+00:00",
//        "day_length": 0,
//        "civil_twilight_begin": "1970-01-01T00:00:01+00:00",
//        "civil_twilight_end": "1970-01-01T00:00:01+00:00",
//        "nautical_twilight_begin": "1970-01-01T00:00:01+00:00",
//        "nautical_twilight_end": "1970-01-01T00:00:01+00:00",
//        "astronomical_twilight_begin": "1970-01-01T00:00:01+00:00",
//        "astronomical_twilight_end": "1970-01-01T00:00:01+00:00"
//    },
//    "status": "OK"
//}


