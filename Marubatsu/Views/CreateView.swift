//
//  CreateView.swift
//  Marubatsu
//
//  Created by yonezawanatsuko on 2025/11/08.
//

import SwiftUI

struct CreateView: View {

    // 各種変数や配列はQuizViewModel.swiftで管理
    @ObservedObject var vm: QuizViewModel

    var body: some View {
        VStack {
            Text("問題文と解答を入力して、追加ボタンを押してください。")
                .foregroundStyle(.gray)
                .padding()

            //テキストフィールド人力したものをquestionTextの変数に代入するよ
            TextField(text: $vm.questionText) {
                Text("問題文を入力してください")
            }
            .padding()
            .textFieldStyle(.roundedBorder)

            //解答を選択するピッカー
            Picker("解答", selection: $vm.selectedAnswer) {
                //\.self:各要素そのものを一意なIDとして使う
                ForEach(vm.answers, id: \.self) { answer in
                    Text(answer)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 300)
            .padding()

            //追加ボタン
            Button("追加") {
                vm.addQuiz(question: vm.questionText, answer: vm.selectedAnswer)
            }
            .padding()

            //削除ボタン
            Button {
                vm.quizzesArray.removeAll()  //配列を空にする
                UserDefaults.standard.removeObject(forKey: "quiz")  //保存されているものを削除
            } label: {
                Text("全削除")
                    .foregroundStyle(.red)
                    .padding()
            }
            //【平日課題】作成した問題をリスト化し、
            List {
                ForEach(vm.quizzesArray) { quiz in
                    HStack{
                        Text("問題:\(quiz.question)")
                        Spacer()
                        Text("解答:\(quiz.answer ? "O" : "X")")
                    }
                }
                /// 行入れ替え操作時に呼び出す処理の指定
                .onMove(perform: vm.replaceRow)//行の入れ替え
                .onDelete(perform: vm.deleterRow)//行の削除
            }
            .toolbar {EditButton()}//Editボタンの追加
        }
    }
    // 各種関数はQuizViewModel.swiftで管理
}

#Preview {
        CreateView(vm:QuizViewModel())
}
