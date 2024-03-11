
import SwiftUI


struct MainHubView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isHovered = false
    
    var body: some View {
        if let user = viewModel.currentUser{
            NavigationStack {
                ZStack{
                    VStack (spacing: 50){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Hi,")
                                    .font(Font.custom("AppleGothic", fixedSize: 30))
                                    .tracking(4)
                                    .foregroundColor(.black)
                                    .fontWeight(.black)
                            
                                Text("\(user.username) ! ")
                                    .font(Font.custom("AppleGothic", fixedSize: 30))
                                    .tracking(4)
                                    .foregroundColor(.black)
                                    .fontWeight(.black)
                            }
                            Spacer()
                                .frame(width: 100)
                            NavigationLink(destination: UserProfileView() ){
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .foregroundColor(Color.black)
                            }
                        }
                        
                        VStack {
                            
                            NavigationLink(destination: searchGymView()) {
                                
                                MainHubCardViews(title: "Search Gym")
                                
                            }
    
                            NavigationLink(destination: apiHub()) {
                                
                                MainHubCardViews(title: "Api Func")
                            }
                                                                                    
                            NavigationLink(destination:  workoutListView()) {
                                
                                MainHubCardViews(title: "My Workouts")
                            }
                             
                            NavigationLink(destination: mealListView(mealViewModel: MealViewModel())) {
                                
                                MainHubCardViews(title: "My Meals")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MainHubView_Previews: PreviewProvider {
    static var previews: some View {
        MainHubView()
    }
}
