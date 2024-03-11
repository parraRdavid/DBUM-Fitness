
import SwiftUI
import Firebase
import FirebaseFirestore

struct workoutListView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var workoutViewModel = workout_exercise_ViewModel()
    @State private var presentSheet2 = false
    @State private var selectedWorkout: Workout? // Declare selectedWorkout
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                VStack {
                    Spacer()
                    Text("\(user.username)'s Workouts !")
                        .font(Font.custom("AppleGothic", fixedSize: 30))
                        .tracking(4)
                        .bold()
                    
                    VStack(spacing: 15){
                        
                        Text("Click button to add workout and slide left to delete workout")
                            .font(.custom("AppleGothic", fixedSize: 15))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        
                        Button(action: {
                            if !self.presentSheet2 {
                                self.presentSheet2.toggle()
                            }
                        }) {
                            Text("Add Workout")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .font(.custom("AppleGothic", fixedSize: 20))
                                .bold()
                                .background(Color.indigo)
                                .cornerRadius(20)
                        }
                        .sheet(isPresented: $presentSheet2) {
                            inputWorkoutToListView()
                                .environmentObject(viewModel)
                                .environmentObject(workoutViewModel)
                                .presentationDetents([.medium, .large])
                        }
                    }
                    .padding()
                    
                    
                    List {
                        ForEach(workoutViewModel.workouts) { workout in
                            NavigationLink(destination: exerciseListView(selectedWorkout: workout)) {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack (alignment: .center){
                                        Text(workout.name)
                                            .font(Font.custom("AppleGothic", fixedSize: 25))
                                            .fontWeight(.semibold)
                                            .minimumScaleFactor(0.5)
                                        Image(systemName: "figure.cooldown")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(Color.indigo)
                                    }
                                    Text(workout.description)
                                        .font(.custom("AppleGothic", fixedSize: 15))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .onTapGesture {
                                selectedWorkout = workout
                            }
                        }
                        .onDelete { indexSet in
                            guard let index = indexSet.first else { return }
                            let workoutToDelete = workoutViewModel.workouts[index]
                            workoutViewModel.deleteWorkout(workoutID: workoutToDelete.id)
                        }
                    }
                    .onAppear {
                        workoutViewModel.fetchData()
                    }
                }
            }
        }
    }
}
