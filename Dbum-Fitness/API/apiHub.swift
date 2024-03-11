
import SwiftUI

struct apiHub: View {
    var body: some View {
        NavigationView{
            
            VStack(spacing: 50){
                Text("API Hub")
                    .font(Font.custom("AppleGothic", fixedSize: 40))
                    .tracking(4)
                    .foregroundColor(.black)
                    .fontWeight(.black)
                
                
                Text("These are the 2 required api functions")
                    .font(.custom("AppleGothic", fixedSize: 20))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                NavigationLink(destination: api1View()) {
                    
                    MainHubCardViews(title: "Api 1: Fetch Workouts")
                }
                NavigationLink(destination: api2View()) {
                    
                    MainHubCardViews(title: "Api 2: Fetch Food Facts")
                }
            }
            
        }
    }
}

struct apiHub_Previews: PreviewProvider {
    static var previews: some View {
        apiHub()
    }
}
