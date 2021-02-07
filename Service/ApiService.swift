//
//  ApiService.swift
//  ArabamAssignment
//
//  Created by Batuhan Baran on 27.01.2021.
//

import Foundation


class Service{
    

    func fetchData(sort: Int, sortDirection: Int,skip: Int,take: Int,comletionHandler: @escaping(Result<[CarModel],Error>) -> Void){
        
        let url = URL(string: "http://sandbox.arabamd.com/api/v1/listing?&skip=\(skip)&take=\(take)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //minYear=2018&maxYear=2020
            guard let data = data else {return}
            
            do{
                
                let carData = try JSONDecoder().decode([CarModel].self, from: data)
                
                comletionHandler(.success(carData))
                
            }catch let error{
                
                comletionHandler(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchDataWithFilter(minYear: String, maxYear: String,sort: Int, sortDirection: Int,skip: Int,take: Int,comletionHandler: @escaping(Result<[CarModel],Error>) -> Void){
        
        let url = URL(string: "http://sandbox.arabamd.com/api/v1/listing?minYear=\(minYear)&maxYear=\(maxYear)&sort=\(sort)&sortDirection=\(sortDirection)&skip=\(skip)&take=\(take)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //minYear=2018&maxYear=2020
            guard let data = data else {return}
            
            do{
                
                let carData = try JSONDecoder().decode([CarModel].self, from: data)
                
                comletionHandler(.success(carData))
                
            }catch let error{
                
                comletionHandler(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchCarDetail(advertId: Int,comletionHandler: @escaping(Result<CarDetail,Error>) -> Void){
        
        let url = URL(string: "http://sandbox.arabamd.com/api/v1/detail?id=\(advertId)")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                
                let carData = try JSONDecoder().decode(CarDetail.self, from: data)
                comletionHandler(.success(carData))
                
            }catch (let error){
                
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    
}

