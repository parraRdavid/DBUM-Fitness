
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


struct Meal: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var mealName: String
    var mealType: String
    var cals: Int
    var protein: Int
    var carbs: Int
    var fats: Int
    var dateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}

class MealViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    @Published var startDate = Date()
    private var db = Firestore.firestore()
    
    func deleteMeal(mealID: UUID, date: Date) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        print("User UID: \(userUID)")

        // Find the meal index with the given ID and date
        if let index = self.meals.firstIndex(where: { $0.id == mealID && Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            let mealToDelete = self.meals[index]
            print("Meal to delete:")
            print("Meal Name: \(mealToDelete.mealName)")
            print("Meal Type: \(mealToDelete.mealType)")
            print("Date: \(mealToDelete.dateFormatted)")

            let db = Firestore.firestore()
            let mealDocumentRef = db.collection("users").document(userUID).collection("meals").document(mealID.uuidString)

            mealDocumentRef.delete { error in
                if let error = error {
                    print("Error deleting meal: \(error.localizedDescription)")
                } else {
                    // Perform the UI update on the main thread
                    DispatchQueue.main.async {
                        self.meals.remove(at: index)
                        print("Meal deleted successfully.")
                        // You might want to trigger UI updates or perform additional actions here.
                    }
                }
            }
        } else {
            print("Meal not found.")
        }
    }
        
        
    func fetchMealData(completion: @escaping () -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }

        let mealsRef = db.collection("users").document(userUID).collection("meals")
        
        let startOfDay = Calendar.current.startOfDay(for: startDate)
        let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startDate)!
        
        print("Fetching data for date: \(startOfDay) to \(endOfDay)")
        
        mealsRef
            .whereField("date", isGreaterThanOrEqualTo: startOfDay)
            .whereField("date", isLessThanOrEqualTo: endOfDay)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    self.meals = []
                    completion()
                    return
                }

                let fetchedMeals: [Meal] = documents.compactMap { document in
                    guard let data = document.data() as? [String: Any], // Explicitly cast data to [String: Any]
                          let dateTimestamp = data["date"] as? Timestamp,
                          let mealName = data["mealName"] as? String,
                          let mealType = data["mealType"] as? String,
                          let cals = data["cals"] as? Int,
                          let protein = data["protein"] as? Int,
                          let carbs = data["carbs"] as? Int,
                          let fats = data["fats"] as? Int else {
                        return nil
                    }

                    let meal = Meal(
                        date: dateTimestamp.dateValue(),
                        mealName: mealName,
                        mealType: mealType,
                        cals: cals,
                        protein: protein,
                        carbs: carbs,
                        fats: fats
                    )

                    return meal
                }

                // Update meals only if there are fetched meals
                self.meals = fetchedMeals
                print("Meals for the selected date:")
                self.meals.forEach { meal in
                    print("Date: \(meal.dateFormatted), Meal Name: \(meal.mealName), Meal Type: \(meal.mealType)")
                }

                completion()
            }
    }
    }


