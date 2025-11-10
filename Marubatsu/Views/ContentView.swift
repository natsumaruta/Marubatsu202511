//
//  ContentView.swift
//  Marubatsu
//
//  Created by yonezawanatsuko on 2025/11/08.
//

import SwiftUI

//Quixの構造体はModelsフォルダのQuiz.swiftで管理

struct ContentView: View {
    
    let quizExample = QuizData.quizExample
    
    // initや各種変数はQuizViewModel.swiftで管理
    @StateObject var vm = QuizViewModel() //ViewModelのクラスを呼ぶ
    
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
                            CreateView(vm: vm)
                                .navigationTitle("問題を作ろう")
                        }label:{
                            Image(systemName: "plus")
                                .font(.title)
                        }
                    }
                }
                //上記Viewが画面上に表示されるタイミングを検知して、クロージャ内のcurrentQuestionNumを0にする処理を実行
//                .onAppear{
                      // 配列が変わったら[0]に戻す
//                    vm.currentQuestionNum = 0
//                }
                
                //【平日課題】配列変更・削除後に１問目を表示する
                //quizzesArrayの変化を検知して、クロージャ内のcurrentQuestionNumを0にする処理を実行
                //.compactMap { $0.id } : id(UUID) の配列が変化
                // $0 は配列の中の1つの要素
                .onChange(of: vm.quizzesArray.compactMap{ $0.id }) {
                    // 配列が変わったら[0]に戻す
                    vm.currentQuestionNum = 0
                }
            }
        }
    }
    // 各種関数はQuizViewModel.swiftで管理
}

#Preview {
    ContentView()
}
