
import SwiftUI
import Firebase
import FirebaseFirestore


struct inputExerciseToListView: View {
    
    @State private var resultMessage: String = ""
    @State private var exercisename = ""
    @State private var exerciseReps = ""
    @State private var exerciseDesc = ""
    @StateObject var workoutViewModel = workout_exercise_ViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    var selectedWorkout: Workout
    
    var body: some View {
        if viewModel.currentUser != nil {
            
            VStack {
                TextField("Exercise Name", text: $exercisename)
                TextField("Add sets and reps i.e 2 x 5", text: $exerciseReps)
                TextField("Description", text: $exerciseDesc)
            }
            .textFieldStyle(TextFieldBorder())
            
            Text(resultMessage)
                .foregroundColor(resultMessage == "Exercise uploaded successfully" ? .green : .red)
                .padding()
            
            Button(action: {
                if exercisename.isEmpty || exerciseReps.isEmpty || exerciseDesc.isEmpty {
                    resultMessage = "Invalid input. Please make sure all fields are filled in."
                } else {
                    workoutViewModel.checkAndUpdate(workout: selectedWorkout,
                                                    exerciseName: exercisename,
                                                    exerciseReps: exerciseReps,
                                                    exerciseDesc: exerciseDesc) { success in
                        if success {
                            resultMessage = "Exercise uploaded successfully"
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
