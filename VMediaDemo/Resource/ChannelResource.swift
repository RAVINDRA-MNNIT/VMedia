//
//  ChannelResource.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 25/06/23.
//

import Foundation

struct ChannelResource
{
    func getChannels(completion : @escaping (_ result: Channel?) -> Void)
    {
        let channelUrl = URL(string: ApiEndpoints.channels)!
        let httpUtility = HttpUtility.shared
        httpUtility.getApiData(requestUrl: channelUrl, resultType: Channel.self) { (channelApiResponse) in
            _ = completion(channelApiResponse)
        }
    }
}
