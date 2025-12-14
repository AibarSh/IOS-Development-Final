//
//  Models.swift
//  AShVelo
//
//  Created by Macbook Air on 12.12.2025.
//

import Foundation

struct bicycle{
    struct frame{
        var size = Sizes.m
        var company: Companies1 = .shimano
        var company2: Companies2 = .merida
        var type: BikeType = .mtb
        var color: Color = .black
        var price: Int = 100000
        
    }
}

enum Sizes: String{
    case s = "S"
    case m = "M"
    case l = "L"
    case xl = "XL"
}

enum BikeType: String{
    case mtb = "MTB"
    case road = "Road"
    case bmx = "BMX"
}

enum Color: String{
    case black = "Black"
    case red = "Red"
    case blue = "Blue"
    case green = "Green"
    case yellow = "Yellow"
    case white = "White"
    case purple = "Purple"
}

enum Companies1: String{
    case shimano = "Shimano"
    case sram = "Sram"
}

enum Companies2: String{
    case merida = "Merida"
    case giant = "Giant"
    case cube = "Cube"
    case scott = "Scott"
    case specialized = "Specialized"
}
