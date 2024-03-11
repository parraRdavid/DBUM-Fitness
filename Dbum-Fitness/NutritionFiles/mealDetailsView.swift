
import SwiftUI
import Firebase
import FirebaseFirestore


struct mealDetailsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var mealViewModel: MealViewModel
    var selectedMeal: Meal
    
    var body: some View {
        if viewModel.currentUser != nil {
            NavigationStack {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Meal Details")
                            .font(.custom("AppleGothic", fixedSize: 35))
                            .bold()
                            .tracking(4)
                                                    
                        HStack {
                            Text("Calories: ")
                                .font(.custom("AppleGothic", fixedSize: 25))
                                .foregroundColor(Color.indigo)
                            Text("\(selectedMeal.cals)")
                                .font(.custom("AppleGothic", fixedSize: 20))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                            Text("Protein(g): ")
                                .font(.custom("AppleGothic", fixedSize: 25))
                                .foregroundColor(Color.indigo)
                            Text("\(selectedMeal.protein)")
                                .font(.custom("AppleGothic", fixedSize: 20))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                            Text("Carbs(g): ")
                                .font(.custom("AppleGothic", fixedSize: 25))
                                .foregroundColor(Color.indigo)
                            Text("\(selectedMeal.carbs)")
                                .font(.custom("AppleGothic", fixedSize: 20))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                            Text("Fats(g): ")
                                .font(.custom("AppleGothic", fixedSize: 25))
                                .foregroundColor(Color.indigo)
                            Text("\(selectedMeal.fats)")
                                .font(.custom("AppleGothic", fixedSize: 20))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

