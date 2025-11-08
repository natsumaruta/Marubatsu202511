//
//  QuizData.swift
//  Marubatsu
//
//  Created by yonezawanatsuko on 2025/11/08.
//

import Foundation

//設計図（＝型や構造体）」から実際に作られた“モノ”のこと

//enum:データを列挙する
enum QuizData{
    //static:共通データ(どのファイルからでも呼び出せる)
    static let quizExample: [Quiz] = [
        Quiz(question: "iPhoneアプリを開発する統合環境はZcodeである", answer: false),
        Quiz(question: "Xcode画面の右側にはユーティリティーズがある", answer: true),
        Quiz(question: "Textは文字列を表示する際に利用する", answer: true)
    ]
}
