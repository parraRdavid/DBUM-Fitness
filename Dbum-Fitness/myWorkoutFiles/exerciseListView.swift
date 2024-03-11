
import SwiftUI
import Firebase
import FirebaseFirestore

struct exerciseListView: View {
    @StateObject var workoutViewModel = workout_exercise_ViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var presentSheet2 = false
    @State var showingAddWorkoutAlert = false
    @State private var isAddingWorkout = false
    @State private var updatedExerciseList = false // New state variable
    
    var selectedWorkout: Workout
    
    var body: some View {
        if viewModel.currentUser != nil {
            NavigationView {
                VStack {
                    Text("\(selectedWorkout.name) Exercises")
                        .font(Font.custom("AppleGothic", fixedSize: 30))
                        .tracking(4)
                        .bold()
                    
                    VStack(spacing: 15) {
                        
                        
                        Text("When you add an exercise, refresh the list to see updated list")
                            .font(.custom("AppleGothic", fixedSize: 15))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            if !self.presentSheet2 {
                                self.presentSheet2.toggle()
                            }
                        }) {
                            Text("Add Exercise")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .font(.custom("AppleGothic", fixedSize: 20))
                                .bold()
                                .background(Color.indigo)
                                .cornerRadius(20)
                        }
                        .sheet(isPresented: $presentSheet2) {
                            inputExerciseToListView(selectedWorkout: selectedWorkout)
                                .environmentObject(viewModel)
                                .environmentObject(workoutViewModel)
                                .presentationDetents([.medium, .large])
                        }
                    }
                    .padding()
                    
                    List {
                        ForEach(selectedWorkout.exercises) { exercise in
                            VStack(alignment: .leading, spacing: 5) {
                                HStack (alignment: .center) {
                                    Text(exercise.name)
                                        .font(Font.custom("AppleGothic", fixedSize: 25))
                                        .fontWeight(.semibold)
                                        .minimumScaleFactor(0.5)
                                    Image(systemName: "figure.cooldown")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(Color.indigo)
                                }
                                Text(exercise.Set_Reps)
                                    .font(.custom("AppleGothic", fixedSize: 15))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(exercise.smallDescription)
                                    .font(.custom("AppleGothic", fixedSize: 15))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onDelete { indexSet in
                            guard let index = indexSet.first else { return }
                            let exerciseToDelete = selectedWorkout.exercises[index]
                            workoutViewModel.deleteExercise(workoutID: selectedWorkout.id, exerciseID: exerciseToDelete.id)
                            updatedExerciseList.toggle() // Toggle the state variable
                        }
                    }
                }
            }
            .padding()
        }
    }
}
