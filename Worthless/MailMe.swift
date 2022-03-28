//
//  mailMe.swift
//  Worthless
//
//  Created by Yauheni Shauchenka on 3/7/22.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {

    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["y.shauchenka+wless@gmail.com"])
        vc.setSubject("Решил отправить денег, помоги понять как")
        vc.setMessageBody("Привет, отличное приложение, однако вот что ещё сюда можно добавить, что бы убедить меня стать китом: </br></br></br></br></br> Кстати я знаю, что это приложение с открытым исходным кодом и даже уже сходил посмотрел открытые тикеты на https://github.com/merc1305/Worthless/issues", isHTML: true)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
    }
}

struct MailMe: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        VStack {
            
            Text("Ок, давай поговорим, как насчет электронной почты? Тапай на кнопку и напиши всё, что обо мне думаешь, не стесняйся!")
                .multilineTextAlignment(.leading)
                .padding()
            
            if MFMailComposeViewController.canSendMail() {
                Button("Написать Жене") {
                    self.isShowingMailView.toggle()
                }
            } else {
                Text("Упс! Похоже это устройство не может отправлять письма, попробуй написать напрямую на y.shauchenka+wless@gmail.com")
                    .padding()
            }
//            if result != nil {
//                Text("Result: \(String(describing: result))")
//                    .lineLimit(nil)
//            }
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: self.$isShowingMailView, result: self.$result)
        }
    }
}

struct mailMe_Previews: PreviewProvider {
    static var previews: some View {
        MailMe()
    }
}
