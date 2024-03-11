
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


struct mealListView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var mealViewModel: MealViewModel
    @State private var presentSheet2 = false
    @State private var presentSheet3 = false
    
    var body: some View {
        if viewModel.currentUser != nil {
            NavigationView {
                VStack {
                    
                    Text("Meal Tracker !")
                        .font(Font.custom("AppleGothic", fixedSize: 33))
                        .tracking(4)
                        .bold()
                    
                    VStack{
                        HStack(spacing: 5){
                            Image(systemName: "calendar.circle")
                                .font(.system(size: 50))
                                .foregroundColor(Color.indigo)
                                .overlay {
                                    DatePicker("", selection: $mealViewModel.startDate, displayedComponents: .date)
                                        .blendMode(.destinationOver)
                                }
                            Text(mealViewModel.startDate, formatter: DateFormatter.mealViewModel)
                                .foregroundColor(.primary)
                                .font(.subheadline)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                        }
                        .padding()
                        
                        Text("Click the calendar icon to choose a date to track meals for")
                            .font(.custom("AppleGothic", fixedSize: 15))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                            .frame(height: 20)
                        
                    }
                    
                    VStack{
                        if mealViewModel.meals.isEmpty {
                            Text("This current date does not have any meals, or you need to reclick the ViewData Button")
                        }
                        else {
                            List {
                                ForEach(mealViewModel.meals) { meal in
                                    HStack {
                                        NavigationLink(destination: mealDetailsView(mealViewModel: MealViewModel(), selectedMeal: meal)){
                                            VStack(alignment: .leading, spacing: 5) {
                                                HStack{
                                                    Text(meal.mealName)
                                                        .font(Font.custom("AppleGothic", fixedSize: 20))
                                                        .fontWeight(.semibold)
                                                        .minimumScaleFactor(0.5)
                                                    Image(systemName: "fork.knife.circle")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 55, height: 25)
                                                        .foregroundColor(Color.indigo)
                                                }
                                                Text(meal.mealType)
                                                    .font(.custom("AppleGothic", fixedSize: 15))
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                                Text(meal.dateFormatted)
                                                    .font(.custom("AppleGothic", fixedSize: 15))
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        
                                    }
                                    .padding()
                                }
                                .onDelete { indexSet in
                                    guard let index = indexSet.first else { return }
                                    let mealToDelete = mealViewModel.meals[index]
                                    mealViewModel.deleteMeal(mealID: mealToDelete.id, date: mealToDelete.date)
                                    
                                }
                            }
                            .navigationBarTitleDisplayMode(.inline)
                        }
                        
                        
                    }
                    HStack {
                        Button(action: {
                            mealViewModel.fetchMealData {}
                        }) {
                            Text("View Data")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .font(.custom("AmericanTypewriter-CondensedLight", fixedSize: 20))
                                .bold()
                                .background(Color.indigo)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            if !self.presentSheet2 {
                                self.presentSheet2.toggle()
                            }
                        }) {
                            Text("Add Meal")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .font(.custom("AmericanTypewriter-CondensedLight", fixedSize: 20))
                                .bold()
                                .background(Color.indigo)
                                .cornerRadius(20)
                        }
                        .sheet(isPresented: $presentSheet2) {
                            inputMealView(selectedDate: mealViewModel.startDate)
                                .environmentObject(viewModel)
                                .presentationDetents([.medium, .large])
                        }
                    }
                }
            }
            .padding()
        }
    }
}


struct mealListView_Previews: PreviewProvider {
    static var previews: some View {
        mealListView(mealViewModel: MealViewModel())
    }
}

extension DateFormatter {
    static let mealViewModel: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
}
