//
//  DetailView.swift
//  TrackerApp
//
//  Created by Miguel Aenlle on 11/14/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var mainDetailViewModel: MainDetailViewModel
    @State var giveMinorOn: Bool = false
    
    
    var body: some View {
        if let studentData = mainDetailViewModel.student {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                
                if !giveMinorOn {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            SpacingView(height: 30)
                            VStack(alignment: .leading) {
                                VStack {
                                    HeaderView(text: studentData.studentName)
                                    Button {
                                        if (studentData.studentEmail != "") {
                                            if let url = URL(string: "mailto:\(studentData.studentEmail)") {
                                                UIApplication.shared.open(url)
                                            }
                                        }
                                    } label: {
                                        TextView(text: studentData.studentEmail, color: Color.blue)
                                            .background(Color.clear)
                                    }
                                }
                                .padding(20)
                                
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: black.opacity(0.1), radius: 20, x: 0, y: 10)
                            .padding(20)
                            SummaryView(mainDetailViewModel: mainDetailViewModel)
                            VStack {
                                SpacingView(height: 30)
                                TextView(text: "Schedule", fontWeight: .bold)
                                if (mainDetailViewModel.schedule.count > 0) {
                                    
                                
                                    ForEach(mainDetailViewModel.schedule.sorted(by: { $0.period < $1.period }), id: \.self) { schedule in
                                        ScheduleView(scheduleData: schedule)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 5)
                                    }
                                    
                                } else {
                                    HStack {
                                        TextView(text: "Student has no classes today.")
                                    }
                                }
                                SpacingView(height: 30)
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: black.opacity(0.1), radius: 20, x: 0, y: 10)
                            .padding(20)
                            
                            VStack {
                                SpacingView(height: 30)
                                HStack {
                                    Spacer()
                                    TextView(text: "Minors", fontWeight: .bold)
                                    Spacer()
                                }
                                
                                SpacingView(height: 30)
                                if mainDetailViewModel.minors.count > 0 {

                                    LazyVStack {
                                        ForEach(mainDetailViewModel.minors, id: \.self) { minor in
                                            MinorView(minor: minor)
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 5)
                                        }
                                        
                                    }
                                } else {
                                    HStack {
                                        Spacer()
                                        TextView(text: "No minors 👍", fontWeight: .regular)
                                        Spacer()
                                    }
                                    
                                }
                                SpacingView(height: 30)
                            }
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: black.opacity(0.1), radius: 20, x: 0, y: 10)
                            .padding(20)
                            
                            
                            VStack {
                                Button {
                                    withAnimation {
                                        self.giveMinorOn = true
                                    }
                                } label: {
                                    ButtonView(text: "Give Minor")
                                }
                            }.padding(20)

                            
                            Spacer()
                        }
                    }
                } else {
                    VStack {
                        HStack {
                            Button {
                                withAnimation {
                                    self.giveMinorOn = false
                                }
                            } label: {
                                TextView(text: "Go back", size: 15, fontWeight: .bold, color: .white)
                                    .background(Color.clear)
                            }
                            Spacer()
                        }
                        .padding(20)
                        GiveMinorView(userID: studentData.studentID, giveMinor: {
                            self.mainDetailViewModel.regenMinors()
                            self.giveMinorOn = false
                        })
                        Spacer()
                    }

                    
                }
            }
        }
    }
}