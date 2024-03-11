
import SwiftUI
import Firebase
import FirebaseFirestore

struct inputMealView: View {
    @State private var mealName = ""
    @State private var mealType = ""
    @State private var cals = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fats = ""
    @State private var resultMessage = ""
    @EnvironmentObject var mealModel: MealViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    var selectedDate: Date
    
    var body: some View {
        if viewModel.currentUser != nil {
            NavigationStack {
                VStack {
                    
                    Text("Selected Date: \(formattedDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                    
                    VStack{
                        VStack(alignment: .leading, spacing: 5){
                            TextField("enter meal name", text: $mealName)
                            
                        }
                        VStack(alignment: .leading, spacing: 5){
                            TextField("enter meal type. i.e: breakfast", text: $mealType)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 5){
                            TextField("enter calories", text: $cals)
                            
                        }
                        VStack(alignment: .leading, spacing: 5){
                            TextField("enter protein", text: $protein)
                            
                        }
                        VStack(alignment: .leading, spacing: 5){
                            TextField("enter carbs", text: $carbs)
                            
                        }
                        VStack(alignment: .leading, spacing: 5){
                            TextField("enter fats", text: $fats)
                            
                        }
                    }
                    .textFieldStyle(TextFieldBorder2())
                    
                    Button(action: saveMeal) {
                        Text("Save Data")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .font(Font.custom("AppleGothic", fixedSize: 25))
                            .bold()
                    }
                    .background(Color.indigo)
                    .cornerRadius(20)
                    
                    Text(resultMessage)
                        .foregroundColor(resultMessage == "Data saved successfully" ? .green : .red)
                        .bold()
                        
                        //.font(.system(size: resultMessage == "Data saved successfully" ? .green : .red)
                    
                    Spacer()
                }
                .textFieldStyle(TextFieldBorder2())
                .padding()
            }
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
    
    func saveMeal() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }

        guard
            let cals = Int(cals),
            let protein = Int(protein),
            let carbs = Int(carbs),
            let fats = Int(fats) else {
            resultMessage = "Invalid input. Make sure all fields are filled in."
            return
        }

        let db = Firestore.firestore()
        let mealsRef = db.collection("users").document(userUID).collection("meals")

        // Generate a new ID for the meal
        let mealID = UUID().uuidString

        let mealData: [String: Any] = [
            "id": mealID,
            "date": selectedDate,
            "mealName": mealName,
            "mealType": mealType,
            "cals": cals,
            "protein": protein,
            "carbs": carbs,
            "fats": fats
        ]

        mealsRef.document(mealID).setData(mealData) { error in
            if let error = error {
                resultMessage = "Error saving data: \(error.localizedDescription)"
            } else {
                resultMessage = "Data saved successfully"
            }
        }
    }
}

struct calorieTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        inputMealView(selectedDate: Date())
    }
}
