//
//  MainViewModel.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    
    var didFetchList: () -> () { get set}
    
    func fetchList()
}

final class MainViewModel: MainViewModelProtocol {
    
    var didFetchList: () -> () = { }
    
    func fetchList() {
        self.didFetchList()
    }
}
