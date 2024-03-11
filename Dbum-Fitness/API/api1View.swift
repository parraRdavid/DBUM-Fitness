
import SwiftUI
import Combine

struct api1View: View {
    
    @StateObject private var viewModel = api1ViewModel()
    @State private var isDetailViewPresented = false
    
    let muscleOptions = [
        "abdominals", "abductors", "adductors", "biceps", "calves", "chest",
        "forearms", "glutes", "hamstrings", "lats", "lower_back", "middle_back",
        "neck", "quadriceps", "traps", "triceps"
    ]
    
    var body: some View {
        NavigationView {
            VStack{
                VStack(spacing: 40) {
                    
                    Text("Exercise API")
                        .font(Font.custom("AppleGothic", fixedSize: 50))
                        .tracking(4)
                        .foregroundColor(.black)
                        .fontWeight(.black)
                    
                    HStack {
                        Text("Muscle Groups:")
                            .font(Font.custom("AppleGothic", fixedSize: 20))
                            .tracking(4)
                            .foregroundColor(.black)
                            .fontWeight(.black)
                        
                        Picker("Select Muscle Group", selection: $viewModel.selectedMuscle) {
                            ForEach(muscleOptions, id: \.self) { muscle in
                                Text(muscle)
                                    .foregroundColor(.red)
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                    }
                    
                    Text("Choose a muscle group that the api offers")
                        .font(.custom("AppleGothic", fixedSize: 15))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    NavigationLink(destination: api1DetailView(viewModel: viewModel)) {
                        Text("Fetch Exercises")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .font(.custom("AppleGothic", fixedSize: 20))
                            .bold()
                            .background(Color.black)
                            .cornerRadius(20)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.fetchExercises()
                        isDetailViewPresented = true
                    })
                }
                .padding()
            }
        }
    }
}
struct api1View_Previews: PreviewProvider {
    static var previews: some View {
        api1View()
    }
}
