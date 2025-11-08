//
//  Quiz.swift
//  Marubatsu
//
//  Created by yonezawanatsuko on 2025/11/08.
//



import Foundation

//設計図（＝型や構造体）」

//Quixの構造体
//struct:Swiftでよく使う「構造体（こうぞうたい）」を作るためのキーワード
//Identifiable:一意に識別できる（＝IDを持つ）の意
//Codable:データを保存や通信のためにエンコード、デコードして変換できるの意
struct Quiz: Identifiable,Codable {
    var id = UUID()
    var question: String
    var answer: Bool
}
