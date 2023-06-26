//
//  ProgramResource.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 25/06/23.
//

import Foundation

struct ProgramResource
{
    func getProgram(completion : @escaping (_ result: Program?) -> Void)
    {
        let programUrl = URL(string: ApiEndpoints.programs)!
        let httpUtility = HttpUtility.shared
        httpUtility.getApiData(requestUrl: programUrl, resultType: Program.self) { (programApiResponse) in
            _ = completion(programApiResponse)
        }
    }
}
