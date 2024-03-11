//
//  UserProfileView.swift
//  Dbum-Fitness
//
//  Created by iMac on 11/3/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser{
            ZStack{
                VStack{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .padding(22)
                        .padding(.top, -80)
                        .foregroundColor(Color.indigo)
                    
                    VStack{
                        Text("\(user.username)")
                            .foregroundColor(Color.black)
                        
                        Text("\(user.email)")
                            .foregroundColor(Color.black)
                        
                    }
                    
                    Button{
                        viewModel.signOut()
                    }label: {
                        
                        Text("Sign Out")
                        
                    }
                    .padding(40)
                    .buttonStyle(PressableButtonStyle())
                }
            }
         
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
