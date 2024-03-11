
import SwiftUI
import Combine

struct Exercise1: Codable, Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}

class api1ViewModel: ObservableObject {
    
    @Published var exercises: [Exercise1] = []
    @Published var selectedMuscle: String = ""
    
    
    func fetchExercises() {
        
        
        let apiKey = "WwbpZ8xfj/7dfz3/zV8hSw==OsArerh8j4Pz1XU6"
        let urlString = "https://api.api-ninjas.com/v1/exercises?muscle=\(selectedMuscle)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([Exercise1].self, from: data)
                DispatchQueue.main.async {
                    self.exercises = response
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    
}
