
import Foundation
import Firebase
import FirebaseFirestore

struct Workout: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var exercises: [Exercise]
}

struct Exercise: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var Set_Reps: String
    var smallDescription: String
}

class workout_exercise_ViewModel: ObservableObject {
    
    @Published var workouts: [Workout] = []
    private var db = Firestore.firestore()
    
    
    
    func saveData(completion: @escaping (Bool) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        // Save each workout to Firebase
        for workout in workouts {
            do {
                // Convert workout object to a dictionary
                let workoutDict = try Firestore.Encoder().encode(workout)
                
                // Save the workout data to Firestore
                db.collection("users").document(userUID).collection("workouts").document(workout.id.uuidString).setData(workoutDict) { error in
                    if let error = error {
                        print("Error saving workout data to Firestore: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        print("Workout data saved to Firestore successfully")
                        completion(true)
                    }
                }
            } catch {
                print("Error encoding workout data for Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    func checkAndUpdate(workout: Workout, exerciseName: String, exerciseReps: String, exerciseDesc: String, completion: @escaping (Bool) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        let workoutID = workout.id.uuidString
        
        db.collection("users").document(userUID).collection("workouts").document(workoutID).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    // Decode the workout data from Firestore
                    if var fetchedWorkout = try? document.data(as: Workout.self) {
                        // Print the details of the existing workout
                        print("Workout exists in the database. Details:")
                        print("ID: \(fetchedWorkout.id)")
                        print("Name: \(fetchedWorkout.name)")
                        print("Description: \(fetchedWorkout.description)")
                        
                        // Add the new exercise to the existing workout
                        let newExercise = Exercise(id: UUID(), name: exerciseName, Set_Reps: exerciseReps, smallDescription: exerciseDesc)
                        fetchedWorkout.exercises.append(newExercise)
                        
                        // Update the workout in the database
                        let updatedWorkoutDict = try Firestore.Encoder().encode(fetchedWorkout)
                        self.db.collection("users").document(userUID).collection("workouts").document(workoutID).setData(updatedWorkoutDict) { error in
                            if let error = error {
                                print("Error updating workout data: \(error.localizedDescription)")
                                completion(false)
                            } else {
                                // Update local data
                                DispatchQueue.main.async {
                                    
                                    if let index = self.workouts.firstIndex(where: { $0.id == workout.id }) {
                                        self.workouts[index] = fetchedWorkout
                                    }
                                    self.objectWillChange.send()
                                    print("Workout updated with new exercise data.")
                                    
                                   
                                }
                                completion(true)
                                self.fetchData()
                            }
                        }
                    }
                } catch {
                    print("Error decoding workout data: \(error.localizedDescription)")
                }
            } else {
                print("Workout does not exist in the database.")
            }
        }
    }
    
    func fetchData() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        db.collection("users").document(userUID).collection("workouts").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching workout data: \(error.localizedDescription)")
                return
            }
            
            // Clear existing workouts before adding new ones
            self.workouts = []
            
            for document in querySnapshot?.documents.reversed() ?? [] {

                    if let workoutData = try? document.data(as: Workout.self) {
                        self.workouts.append(workoutData)
                    }
              
            }
        }
    }
    
    
    func deleteWorkout(workoutID: UUID) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }
        
        // Check if the workout exists locally
        if let index = self.workouts.firstIndex(where: { $0.id == workoutID }) {
            
            
            // Delete workout from Firestore
            db.collection("users").document(userUID).collection("workouts").document(workoutID.uuidString).delete { error in
                if let error = error {
                    print("Error deleting workout from Firestore: \(error.localizedDescription)")
                } else {
                    // Delete workout locally
                    self.workouts.remove(at: index)
                    print("Workout deleted successfully.")
                }
            }
        } else {
            print("Workout does not exist locally.")
        }
    }
    
    
    func deleteExercise(workoutID: UUID, exerciseID: UUID) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("No user logged in.")
            return
        }

        // Reference to the workout document in Firestore
        let workoutDocRef = db.collection("users").document(userUID).collection("workouts").document(workoutID.uuidString)

        workoutDocRef.getDocument { document, error in
            if let error = error {
                print("Error fetching workout data: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                print("Workout does not exist in the database.")
                return
            }

            // if workout exisits, check if exericse is located now
            if var workoutData = try? document.data(as: Workout.self),
               let exerciseIndex = workoutData.exercises.firstIndex(where: { $0.id == exerciseID }) {

                print("Workout found in the database. Details:")
                print("Workout ID: \(workoutID)")
                print("Workout Name: \(workoutData.name)\n\n")

                print("Exercise found in the workout. Details:")
                print("Exercise ID: \(exerciseID)")
                print("Exercise Name: \(workoutData.exercises[exerciseIndex].name)")

                // Remove the exercise from the existing workout locally
                workoutData.exercises.remove(at: exerciseIndex)

                   // Update the workout in the database
                   let updatedWorkoutDict = try? Firestore.Encoder().encode(workoutData)
                   workoutDocRef.setData(updatedWorkoutDict ?? [:]) { error in
                       if let error = error {
                           print("Error updating workout data: \(error.localizedDescription)")
                       } else {
                               print("Exercise deleted successfully from Firebase.")
                       }
                   }

            } else {
                print("Exercise does not exist in the selected workout.")
            }
        }
    }
}
