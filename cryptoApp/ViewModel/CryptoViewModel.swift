//
//  CryptoViewModel.swift
//  cryptoApp
//
//  Created by Asya Güney on 4.11.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    func requestData(){
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
                /*self.cryptoList = cryptos
                 DispatchQueue.main.async //eğer bunu yazmazsan hata verir çünkü görüntüyü değiştirmek istiyoruz ama urlsessionın otomatik thread yeri yüzünden yanlış threadde oluyoruz. bu threadi düzeltmek için bu kodu yazıyoruz */
                
                /*self.tableView.reloadData() //bu kısım tableviewın yenilenmesini sağlar*/
                
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
}


