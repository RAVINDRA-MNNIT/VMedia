
import Foundation

protocol HomeViewModelDelegate {
    func didReceiveChannelResponse(channelResponse: Channel?)
    func didReceiveProgramResponse(programResponse: Program?)
}

struct HomeViewModel
{
    var delegate : HomeViewModelDelegate?

    func getChannel()
    {
        let homeResource = ChannelResource()
        homeResource.getChannels() { (channelApiResponse) in
            DispatchQueue.main.async {
                self.delegate?.didReceiveChannelResponse(channelResponse: channelApiResponse)
            }
        }
    }
    
    func getProgram()
    {
        let homeResource = ProgramResource()
        homeResource.getProgram() { (programApiResponse) in
            DispatchQueue.main.async {
                self.delegate?.didReceiveProgramResponse(programResponse: programApiResponse)
            }
        }
    }
}

