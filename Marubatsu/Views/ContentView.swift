//
//  ContentView.swift
//  Marubatsu
//
//  Created by yonezawanatsuko on 2025/11/08.
//

import SwiftUI

//Quixの構造体
//Identifiable:一意に識別できる（＝IDを持つ）の意なので、これを入れたときは構造体の中にidを入れないといけない
//Codable:データを保存や通信のためにエンコード、デコードして変換できるの意
//struct Quiz: Identifiable,Codable {
//    var id = UUID()
//    var question: String
//    var answer: Bool
//}


struct ContentView: View {
    
    //    let quizExample: [Quiz] = [
    //        Quiz(question: "iPhoneアプリを開発する統合環境はZcodeである", answer: false),
    //        Quiz(question: "Xcode画面の右側にはユーティリティーズがある", answer: true),
    //        Quiz(question: "Textは文字列を表示する際に利用する", answer: true)
    //    ]
//    @AppStorage("quiz") var quizzesData = Data() // UserDefaultsから問題を読み込む(Data型)
//    @State var quizzesArray: [Quiz] = [] //問題を入れておく配列
    
    let quizExample = QuizData.quizExample
    
    //    @State var currentQuestionNum:Int = 0 //今何問目？
    //    @State var showingAlert = false //アラートの表示・非表示を管理
    //    @State var alertTitle = "" //"正解"か"不正解"の文字を入れる用の変数
    
    @StateObject private var vm = QuizViewModel() //ViewModelのクラスを呼ぶ
    
//    init(){
//        if let decodedQuizzes = try? JSONDecoder().decode([Quiz].self, from: quizzesData) {
//            _quizzesArray = State(initialValue: decodedQuizzes)
//        }
//    }
//    
    
    
    var body: some View {
        NavigationStack{
            GeometryReader{geometry in
                VStack {
                    Text(vm.showQuestion())
                        .padding()
                        .frame(width: geometry.size.width*0.85, alignment: .leading)
                        .font(.system(size: 25))
                        .fontDesign(.rounded)
                        .background(.yellow)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            vm.checkAnswer(yourAnswer: true)
                        } label: {
                            Text("O")
                        }
                        .frame(width: geometry.size.width*0.4, height: geometry.size.width*0.4)
                        .font(.system(size: 100,weight:.bold))
                        .foregroundStyle(.white)
                        .background(.red)
                        
                        
                        Button {
                            vm.checkAnswer(yourAnswer: false)
                        } label: {
                            Text("X")
                        }
                        .frame(width: geometry.size.width*0.4, height: geometry.size.width*0.4)
                        .font(.system(size: 100,weight:.bold))
                        .foregroundStyle(.white)
                        .background(.blue)
                        
                    }
                }
                .padding()
                //ズレを直すのに親ViewのサイズをVStackに適用
                .frame(width: geometry.size.width, height: geometry.size.height)//このビューを親ビューと同じ幅・高さ（＝全画面サイズ）に広げる
                .navigationTitle("マルバツクイズ")
                //isPresented:その画面（シートやアラートなど）が“表示されているかどうか”を表す状態
                .alert(vm.alertTitle,isPresented: $vm.showingAlert){//表示状態のバインディング
                    Button("OK", role: .cancel){/*今回は処理なし*/}
                }
                //問題作成画面へ遷移するボタン
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink{
                            CreateView()
                                .navigationTitle("問題を作ろう")
                        }label:{
                            Image(systemName: "plus")
                                .font(.title)
                        }
                    }
                }
            }
        }
    }
    
    //    //問題を表示する関数
    //    func showQuestion() -> String {
    //        let question = quizExample[currentQuestionNum].question
    //        return question
    //    }
    //    //回答をチェックする関数
    //    //正解なら次の問題を表示します
    //    func checkAnswer(yourAnswer:Bool){
    //        let quiz = quizExample[currentQuestionNum]
    //        let answer = quiz.answer
    //        if yourAnswer == answer {//正解の時
    //            alertTitle = "正解"
    //
    //            //現在の問題番号が問題数（quizExample.count）
    //            if currentQuestionNum+1 < quizExample.count {
    //                currentQuestionNum += 1
    //            }else{
    //                currentQuestionNum = 0
    //            }
    //        }else{
    //            alertTitle = "不正解"
    //        }
    //        showingAlert = true
    //    }
    
    
}

#Preview {
    ContentView()
}
