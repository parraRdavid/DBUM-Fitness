
import Foundation
import Combine

struct NutritionItem: Codable, Identifiable {
    let id = UUID()
    let name: String
    let calories: Double
    let servingSize: Double
    let totalFat: Double
    let saturatedFat: Double
    let protein: Double
    let sodium: Double
    let potassium: Double
    let cholesterol: Double
    let totalCarbohydrates: Double
    let fiber: Double
    let sugar: Double
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case calories
        case servingSize = "serving_size_g"
        case totalFat = "fat_total_g"
        case saturatedFat = "fat_saturated_g"
        case protein = "protein_g"
        case sodium = "sodium_mg"
        case potassium = "potassium_mg"
        case cholesterol = "cholesterol_mg"
        case totalCarbohydrates = "carbohydrates_total_g"
        case fiber = "fiber_g"
        case sugar = "sugar_g"
    }
    
}


class api2ViewModel: ObservableObject {
    
    @Published var nutritionData: [NutritionItem] = []
    
    func fetchFoodData(foodQuery: String) {
        let encodedQuery = foodQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=" + encodedQuery)!
        var request = URLRequest(url: url)
        request.setValue("WwbpZ8xfj/7dfz3/zV8hSw==OsArerh8j4Pz1XU6", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data received")
                return
            }
            
            
            do {
                let decodedData = try JSONDecoder().decode([NutritionItem].self, from: data)
                DispatchQueue.main.async {
                    self.nutritionData = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")                }
            
        }
        .resume()
    }
}
