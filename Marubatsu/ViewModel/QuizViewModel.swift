//
//  quizViewModel.swift
//  Marubatsu
//
//  Created by yonezawanatsuko on 2025/11/08.
//

import Foundation
import Combine
import SwiftUI

//ObservableObject:ObservableObject をつけると、そのクラスが「SwiftUIのViewから監視できる」ようになる
class QuizViewModel: ObservableObject {
    
    let quizExample = QuizData.quizExample
    
    //UserDefaultsから問題を読み込んで、問題を入れておく配列に入れる
    @AppStorage("quiz") var quizzesData = Data() // UserDefaultsから問題を読み込む(Data型)
    @Published var quizzesArray: [Quiz] = [] //問題を入れておく配列
    
    //回答をチェックする関数で使用する変数
    //Published:「この変数が変わったら通知してね！」という印をつけるためのプロパティラッパー
    @Published var currentQuestionNum = 0
    @Published var showingAlert = false //アラートの表示・非表示を管理
    @Published var alertTitle = "" //"正解"か"不正解"の文字を入れる用の変数
    
    //問題追加(保存)の関数で使用する変数
    @Published var questionText = "" //入力された問題文
    @Published var selectedAnswer = "O" //選択された解答
    
    
    let answers = ["O","X"]
    
    //
    init(){
        if let decodedQuizzes = try? JSONDecoder().decode([Quiz].self, from: quizzesData) {
            //_変数名:「@ State が包んでいる内部の構造体（State）を直接扱っている」状態
            _quizzesArray = Published(initialValue: decodedQuizzes)
        }
    }
    
    
    var currentQuestion: Quiz {
        quizExample[currentQuestionNum]
    }
    
    //問題を表示する関数
    //他のファイルから呼び出してインスタンス化した場合は、Public funcにしないと呼び出せない
    //基本的にswiftではFunctionはprivateになっているため、同じファイル内でしかインスタンス化できない
    public func showQuestion() -> String {
        var question = "問題がありません！"
        
        //問題があるかどうかのチェック
        //もし quizzesArray が空ではない なら
        if !quizzesArray.isEmpty {
            let quiz = quizzesArray[currentQuestionNum]
            question = quiz.question
        }
        return question
    }
    //回答をチェックする関数
    //正解なら次の問題を表示します
    func checkAnswer(yourAnswer:Bool){
        if quizzesArray.isEmpty {return}//問題がないときは回答チェックしない
        let quiz = quizzesArray[currentQuestionNum]
        let answer = quiz.answer
        if yourAnswer == answer {//正解の時
            alertTitle = "正解"
            
            //現在の問題番号が問題数（quizzesArraycount）
            if currentQuestionNum+1 < quizzesArray.count {
                currentQuestionNum += 1
            }else{
                currentQuestionNum = 0
            }
        }else{
            alertTitle = "不正解"
        }
        showingAlert = true
    }
    
    //問題追加(保存)の関数
    func addQuiz(question:String,answer:String){
        //問題文が空白かどうかチェック
        if question.isEmpty {
            print("問題文が選択されていません")
            return
        }
        
        //保存するためのtrue,falseを入れておく変数
        var savingAnswer = true
        
        //OかXかでtrue,falseを切り替える
        switch answer{
        case "O":
            savingAnswer = true
        case "X":
            savingAnswer = false
        default:
            print("適切な答えが入っていません")
            break
        }
        //newQuizの変数を用意して作った問題を一時的な配列（array）に追加する
        let newQuiz = Quiz(question: question, answer: savingAnswer)
        var array = quizzesArray
        array.append(newQuiz)
        
        let storeKey = "quiz" //UserDefaultsに保存するためのキー
        
        //エンコードできたら保存して、配列も更新
        if let encodedQuizzes = try? JSONEncoder().encode(array) {
//            quizzesData = encodedQuizzes
            UserDefaults.standard.set(encodedQuizzes, forKey: storeKey)
            quizzesArray = array //保存して配列も更新したあと、テキストフィールドを空白に戻す
            print(array)
        }
    }
}
