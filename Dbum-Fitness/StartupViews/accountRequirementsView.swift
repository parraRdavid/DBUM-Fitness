
import SwiftUI

struct accountRequirementsView: View {
    var body: some View {
        
        VStack(spacing: 40){
            SignIn_UpFonts(title: "Account Requirements")
                .font(Font.custom("AppleGothic", fixedSize: 40))
                .bold()
            
            VStack(alignment: .leading, spacing: 20){
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Email:")
                        .font(Font.custom("AppleGothic", fixedSize: 20))
                        .tracking(4)
                        .foregroundColor(.black)
                        .fontWeight(.black)
                    Text("- Must have @ sign included")
                        .font(.custom("AppleGothic", fixedSize: 15))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Username:")
                        .font(Font.custom("AppleGothic", fixedSize: 20))
                        .tracking(4)
                        .foregroundColor(.black)
                        .fontWeight(.black)
                    Text("- make sure its appropriate")
                        .font(.custom("AppleGothic", fixedSize: 15))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Password:")
                        .font(Font.custom("AppleGothic", fixedSize: 20))
                        .tracking(4)
                        .foregroundColor(.black)
                        .fontWeight(.black)
                    Text("- Must be 6 or more characters")
                        .font(.custom("AppleGothic", fixedSize: 15))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 300, height: 250)
            .border(Color.gray, width: 3)
            .cornerRadius(8)
        }
    }
}

struct accountRequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        accountRequirementsView()
    }
}
