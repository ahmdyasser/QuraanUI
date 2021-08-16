//
//  ViewController.swift
//  QuraanUI
//
//  Created by Ahmad Yasser on 09/07/2021.
//

import Foundation
import UIKit
struct Networking {
    struct Quraan: Codable {
        var data: QuraanData
    }
    struct QuraanData: Codable {
        var number: Int
        var ayahs: [Ayah]
    }

    struct Ayah: Codable {
        var number: Int
        var text: String
        var surah: Surah
        var numberInSurah: Int
    }

    struct Surah: Codable {
        var number: Int
        var name: String
        var numberOfAyahs: Int
    }
   
    func fechData(pageNumber: Int, completion: @escaping (String, String, String) -> Void) {
        var surahText = ""
        var surahName = ""
        var ayahNumber = ""
        var middleSurahName = ""
        var surahNumber = 1
        if let url = URL(string: "https://api.alquran.cloud/v1/page/\(pageNumber)/quran-uthmani") {
            let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
//                        for family: String in UIFont.familyNames {
//                            print(family)
//                            for names: String in UIFont.fontNames(forFamilyName: family) {
//                                print("==\(names)")
//                            }
//                        }
                      let decodedData = try jsonDecoder.decode(Quraan.self, from: data)
                     surahNumber = decodedData.data.ayahs[0].surah.number
                        for i in 0..<decodedData.data.ayahs.count {
                            surahNumber = decodedData.data.ayahs[i].surah.number
//                            print("\(decodedData.data.ayahs[i].text)\(ayahNumber.enToArDigits)")
                          
                            
                            ayahNumber = String(decodedData.data.ayahs[i].numberInSurah)
                            if decodedData.data.ayahs[i].numberInSurah == 1 {
                                surahText.append("\n\n\(decodedData.data.ayahs[i].text) \(ayahNumber.enToArDigits)")
                            } else {
                                
                                surahText.append("\(decodedData.data.ayahs[i].text) \(ayahNumber.enToArDigits)")
                            }
                            surahName = decodedData.data.ayahs[i].surah.name
                            
                            
                    
                            
                           
                        }
//                        surahName = decodedData.data.ayahs[0].surah.name
                        completion(surahText, surahName, middleSurahName)
                        
                       
                    } catch {
                        print("error in decoding: \(error.localizedDescription)")
                    }
                }
            }
            session.resume()
          
        }
        
    }
    
}

extension String {
    public var enToArDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $1, with: $0)}
        return txt
    }
}



