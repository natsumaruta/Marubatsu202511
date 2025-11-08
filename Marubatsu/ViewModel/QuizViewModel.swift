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
    //「この変数が変わったら通知してね！」という印をつけるためのプロパティラッパー
    @Published var currentQuestionNum = 0
    @Published var showingAlert = false //アラートの表示・非表示を管理
    @Published var alertTitle = "" //"正解"か"不正解"の文字を入れる用の変数
    
    let quizExample = QuizData.quizExample
    
    var currentQuestion: Quiz {
        quizExample[currentQuestionNum]
    }
    
    //問題を表示する関数
    func showQuestion() -> String {
        let question = quizExample[currentQuestionNum].question
        return question
    }
    //回答をチェックする関数
    //正解なら次の問題を表示します
    func checkAnswer(yourAnswer:Bool){
        let quiz = quizExample[currentQuestionNum]
        let answer = quiz.answer
        if yourAnswer == answer {//正解の時
            alertTitle = "正解"
            
            //現在の問題番号が問題数（quizExample.count）
            if currentQuestionNum+1 < quizExample.count {
                currentQuestionNum += 1
            }else{
                currentQuestionNum = 0
            }
        }else{
            alertTitle = "不正解"
        }
        showingAlert = true
    }
}
