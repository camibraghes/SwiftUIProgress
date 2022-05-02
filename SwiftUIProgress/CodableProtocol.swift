//
//  CodableProtocol.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 01.05.2022.
//

import SwiftUI

// Codabale = Decodable + Encodable
struct CustumerModel: Identifiable, Codable {
    var id : String
    let name: String
    let points: Int
    let isPremium: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//
//    init(id: String, name: String, points:Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
    
}

class CodableProtocolViewModel: ObservableObject {
    
    @Published var custumer:  CustumerModel? = nil
    
    init() {
        getdata()
    }
    
    func getdata() {
        guard let data = getJSONData() else {return}
        self.custumer = try? JSONDecoder().decode(CustumerModel.self, from: data)

//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String:Any],
//                let id = dictionary["id"] as? String,
//                let name = dictionary["name"] as? String,
//                let points = dictionary["points"] as? Int,
//                let isPremium = dictionary["isPremium"] as? Bool {
//
//
//            let newcustomer = CustumerModel(id: id, name: name, points: points, isPremium: isPremium)
//            custumer = newcustomer
//        }
        
//        do {
//            self.custumer = try JSONDecoder().decode(CustumerModel.self, from: data)
//        } catch let error {
//            print("error decoding\(error)")
//        }
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustumerModel(id: "13425", name: "George", points: 134, isPremium: false)
        let jasonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String:Any] = [
//            "id": "1232",
//            "name" : "Charlie",
//            "points": 54,
//            "isPremium": true
//        ]
//
//        let jasonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jasonData
    }
}

struct CodableProtocol: View {
    
    @StateObject var viewModel = CodableProtocolViewModel()
    
    var body: some View {
        VStack{

            
            if let customer = viewModel.custumer {
                
                Text(customer.name)
                Text(customer.id)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
       
    }
}

struct CodableProtocol_Previews: PreviewProvider {
    static var previews: some View {
        CodableProtocol()
    }
}
