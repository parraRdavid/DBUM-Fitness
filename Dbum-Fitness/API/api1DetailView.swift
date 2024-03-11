
import SwiftUI
import Combine

struct api1DetailView: View {
    @ObservedObject var viewModel: api1ViewModel
    var body: some View {
        VStack{
            List(viewModel.exercises, id: \.name) { exercise in
                VStack(alignment: .leading) {
                    HStack{
                        Text("Name:")
                            .font(.custom("AppleGothic", fixedSize: 20))
                            .foregroundColor(.red)
                        Text("\(exercise.name)")
                            .font(.custom("AppleGothic", fixedSize: 23))
                    }
                    HStack{
                        Text("Type:")
                            .font(.custom("AppleGothic", fixedSize: 20))
                            .foregroundColor(.red)
                        Text("\(exercise.type)")
                            .font(.custom("AppleGothic", fixedSize: 23))
                    }
                    HStack{
                        Text("Equipment:")
                            .font(.custom("AppleGothic", fixedSize: 20))
                            .foregroundColor(.red)
                        Text("\(exercise.equipment)")
                            .font(.custom("AppleGothic", fixedSize: 23))
                    }
                    HStack{
                        Text("Difficulty:")
                            .font(.custom("AppleGothic", fixedSize: 20))
                            .foregroundColor(.red)
                        Text("\(exercise.difficulty)")
                            .font(.custom("AppleGothic", fixedSize: 23))
                    }
                    HStack{
                        Text("Muscle:")
                            .font(.custom("AppleGothic", fixedSize: 20))
                            .foregroundColor(.red)
                        Text("\(exercise.muscle)")
                            .font(.custom("AppleGothic", fixedSize: 23))
                    }
                }
            }
        }
    }
}

struct api1DetailView_Previews: PreviewProvider {
    static var previews: some View {
        api1DetailView(viewModel: api1ViewModel())
    }
}
