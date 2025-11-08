//
//  CreateView.swift
//  Marubatsu
//
//  Created by yonezawanatsuko on 2025/11/08.
//

import SwiftUI

struct CreateView: View {
    
    
    @ObservedObject  var vm: QuizViewModel
//    @ObservedObject private var vm = QuizViewModel() //ViewModelのクラスを呼ぶ
    
//    @State private var questionText = ""
//    @State private var selectedAnswer = "O"
    
//    let answers = ["O","X"]
    
    var body: some View {
        VStack{
            Text("問題文と解答を入力して、追加ボタンを押してください。")
                .foregroundStyle(.gray)
                .padding()
            
            //テキストフィールド人力したものをquestionTextの変数に代入するよ
            TextField(text:$vm.questionText){
                Text("問題文を入力してください")
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            //解答を選択するピッカー
            Picker("解答",selection: $vm.selectedAnswer) {
                //\.self:各要素そのものを一意なIDとして使う
                ForEach(vm.answers,id:\.self){answer in
                    Text(answer)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth:300)
            .padding()
            
            //追加ボタン
            Button("追加"){
                vm.addQuiz(question:vm.questionText,answer:vm.selectedAnswer)
            }
            .padding()
            
            //削除ボタン
            Button{
                vm.quizzesArray.removeAll() //配列を空にする
                UserDefaults.standard.removeObject(forKey: "quiz") //保存されているものを削除
            }label:{
                Text("全削除")
                    .foregroundStyle(.red)
                    .padding()
            }
        }
    }
//    //問題追加(保存)の関数
//    func addQuiz(question:String,answer:String){
//        //問題文が空白かどうかチェック
//        if question.isEmpty {
//            print("問題文が選択されていません")
//            return
//        }
//        
//        //保存するためのtrue,falseを入れておく変数
//        var savingAnswer = true
//        
//        //OかXかでtrue,falseを切り替える
//        switch answer{
//        case "O":
//            savingAnswer = true
//        case "X":
//            savingAnswer = false
//        default:
//            print("適切な答えが入っていません")
//            break
//        }
//        //newQuizの変数を用意して作った問題を一時的な配列（array）に追加する
//        let newQuiz = Quiz(question: question, answer: savingAnswer)
//        var array:[Quiz] = []
//        array.append(newQuiz)
//        
//        let storeKey = "quiz" //UserDefaultsに保存するためのキー
//        
//        //エンコードできたら保存して、配列も更新
//        if let encodedQuizzes = try? JSONEncoder().encode(array) {
//            UserDefaults.standard.set(encodedQuizzes, forKey: storeKey)
//            questionText = "" //保存して配列も更新したあと、テキストフィールドを空白に戻す
//        }
//    }

    
}

#Preview {
//    CreateView()
}
