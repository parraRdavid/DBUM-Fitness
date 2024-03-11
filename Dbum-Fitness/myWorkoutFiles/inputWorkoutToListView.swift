
import SwiftUI
import Firebase
import FirebaseFirestore


struct inputWorkoutToListView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var workoutViewModel: workout_exercise_ViewModel
    @State private var workoutname = ""
    @State private var workoutDesc = ""
    @State private var resultMessage: String = ""
    @State private var exercises: [Exercise] = []
    
    var body: some View {
        if viewModel.currentUser != nil {
            
            VStack {
                TextField("Workout name", text: $workoutname)
                TextField("Workout description", text: $workoutDesc)
            }
            .textFieldStyle(TextFieldBorder())
            
            Text(resultMessage)
                .foregroundColor(resultMessage == "Workout uploaded successfully" ? .green : .red)
                .padding()
            
            Button(action: {
                if workoutname.isEmpty || workoutDesc.isEmpty {
                    resultMessage = "Invalid input. Please make sure all fields are filled in."
                } else{
                    
                    let newWorkout = Workout(id: UUID(), name: workoutname, description: workoutDesc, exercises: exercises)
                    workoutViewModel.workouts.append(newWorkout)
                    workoutViewModel.saveData() { success in
                        if success {
                            workoutViewModel.fetchData()
                            resultMessage = "Workout uploaded successfully"
                        } else {
                            resultMessage = "Invalid input. Please check your data."
                        }
                    }
                }
                
            }) {
                Text("Create")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .font(Font.custom("AppleGothic", fixedSize: 25))
                    .bold()
            }
            .background(Color.indigo)
            .cornerRadius(20)
        }
    }
}

