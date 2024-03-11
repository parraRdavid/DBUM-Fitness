
import SwiftUI

struct api2View: View {
        @StateObject private var viewModel2 = api2ViewModel()
        @State private var foodInput: String = ""
        
        var body: some View {

                VStack(spacing: 40) {
                    Text("Food Facts API")
                        .font(Font.custom("AppleGothic", fixedSize: 40))
                        .tracking(4)
                        .foregroundColor(.black)
                        .fontWeight(.black)
                    
                    TextField("Enter food", text: $foodInput)
                        .padding()
                    
                    Text("Type in a food of choice, the api will return data \n e.x: 1 Chicken Breast")
                        .font(.custom("AppleGothic", fixedSize: 15))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
                    Button("Fetch Nutrition Data") {
                        viewModel2.fetchFoodData(foodQuery: foodInput)
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .font(.custom("AppleGothic", fixedSize: 20))
                    .bold()
                    .background(Color.black)
                    .cornerRadius(20)
                    
                    ForEach(viewModel2.nutritionData) { item in
                        VStack(alignment: .leading) {
                            Group {
                                
                                HStack{
                                    Text("Name:")
                                        .font(.custom("AppleGothic", fixedSize: 20))
                                        .foregroundColor(.red)
                                    Text("\(String(item.name))")
                                        .font(.custom("AppleGothic", fixedSize: 23))
                                }
                                HStack{
                                    Text("Serving Size:")
                                        .font(.custom("AppleGothic", fixedSize: 20))
                                        .foregroundColor(.red)
                                    Text("\(String(item.calories))g")
                                        .font(.custom("AppleGothic", fixedSize: 23))
                                }
                                HStack{
                                    Text("Calories:")
                                        .font(.custom("AppleGothic", fixedSize: 20))
                                        .foregroundColor(.red)
                                    Text("\(String(item.calories))")
                                        .font(.custom("AppleGothic", fixedSize: 23))
                                }
                                HStack{
                                    Text("Protein:")
                                        .font(.custom("AppleGothic", fixedSize: 20))
                                        .foregroundColor(.red)
                                    Text("\(String(item.protein))g")
                                        .font(.custom("AppleGothic", fixedSize: 23))
                                }
                                HStack{
                                    Text("Carbs:")
                                        .font(.custom("AppleGothic", fixedSize: 20))
                                        .foregroundColor(.red)
                                    Text("\(String(item.totalCarbohydrates))g")
                                        .font(.custom("AppleGothic", fixedSize: 23))
                                }
                                HStack{
                                    Text("Fats:")
                                        .font(.custom("AppleGothic", fixedSize: 20))
                                        .foregroundColor(.red)
                                    Text("\(String(item.totalFat))g")
                                        .font(.custom("AppleGothic", fixedSize: 23))
                                }
                              
                            }
                         
                        }
                        .padding()
                        .border(Color.gray, width: 3)
                        .cornerRadius(8)
                       
                    }
            }
            .padding()
            .textFieldStyle(TextFieldBorder())
            .onAppear {
                viewModel2.fetchFoodData(foodQuery: "")
            }
        }
    }

struct api2View_Previews: PreviewProvider {
    static var previews: some View {
        api2View()
    }
}


