//
//  HomeNewVC.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 21/6/23.
//  Copyright © 2023 Ravindra Arya. All rights reserved.
//

import UIKit

class HomeNewVC: UIViewController
{
    // MARK: - Properties
    var filteredList:Channel?
    var homeViewModel = HomeViewModel()
    var captureImageView = UIImageView(frame: CGRect.zero)
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView:UICollectionView!
    {
        didSet
        {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.isDirectionalLockEnabled = true
            collectionView.register(UINib(nibName: "ProgramCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "programCell")
            collectionView.register(UINib(nibName: "ChannelCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "channelCell")
            collectionView.register(UINib(nibName: "TimeCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "timeCell")
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.intialSetup()
    }
    
    override func viewWillLayoutSubviews() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Helper
    private func intialSetup()
    {
        collectionView.contentInsetAdjustmentBehavior = .never
        if let layout = collectionView?.collectionViewLayout as? CustomCollectionViewLayout
        {
            layout.delegate = self
        }
        
        let sideViewToHideTime = UIView(frame: CGRect(x: 0, y: 0, width: 297, height: 40))
        sideViewToHideTime.backgroundColor = UIColor(patternImage: getSnappshot(withRect: CGRect(x: 0, y: 0, width: 297, height: 40)))
        self.view.addSubview(sideViewToHideTime)
        
        captureImageView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.size.width, height: 58)
        captureImageView.layer.zPosition = 1019
        captureImageView.tag = 1019
        self.collectionView.addSubview(captureImageView)
        captureImageView.image = getSnappshot(withRect: CGRect(x: 36, y: 249, width: collectionView.frame.size.width, height: 58))

        homeViewModel.delegate = self
        homeViewModel.getChannel()
    }

    private func getSnappshot(withRect : CGRect) -> UIImage
    {
        let y = withRect.minY.pointsToPixel()
        let width = withRect.width.pointsToPixel()
        let height = withRect.height.pointsToPixel()
        let rect = CGRect(x: withRect.origin.x, y: y, width: width, height: height)
        return Utility.cropImage(image: UIImage(named: "backgroundImage")!, toRect: rect) ?? UIImage()
    }
}

extension HomeNewVC : HomeViewModelDelegate
{
    func didReceiveChannelResponse(channelResponse: Channel?)
    {
        filteredList = channelResponse
        homeViewModel.getProgram()
    }
    
    func didReceiveProgramResponse(programResponse: Program?) {
        guard filteredList != nil else {return}
        for i in 0..<(filteredList!.count)
        {
            filteredList![i].programs = programResponse?.filter{ (program) -> Bool in
                program.recentAirTime.channelID == filteredList![i].id
            }
        }
        collectionView.reloadData()
    }
}

extension HomeNewVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        guard let channels = filteredList, channels.count > 0 else { return 0}
        return (channels.count + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data =  filteredList else { return 0}
        return ((section == 0) ? daysData : ((data[section - 1].programs?.count ?? 0) + 1))
    }


    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
            let timeCell = cell as? TimeCollectionViewCell
            timeCell?.configureCell(indexInt: indexPath.row)
            timeCell?.layer.zPosition = 2000
        }
        else {

            if indexPath.row == 0
            {
                let channelCell = cell as? ChannelCollectionViewCell
                if  let  channel = filteredList?[indexPath.section - 1]
                {
                    channelCell?.configureWith(channel: channel)
                }
            }
            else {
                let programCell = cell as? ProgramCollectionViewCell

                if let channel = filteredList?[indexPath.section - 1], let programs = channel.programs
                {
                    programCell?.configureWithModel(program: programs[indexPath.item - 1], row : indexPath.row)
                }
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0
        {
            guard let timeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as? TimeCollectionViewCell else {return UICollectionViewCell()}
            return timeCell
        }
        else {
            
            if indexPath.row == 0
            {
                guard let channelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelCell", for: indexPath) as? ChannelCollectionViewCell else {return UICollectionViewCell()}

                return channelCell
            }
            else {
                guard let programCell = collectionView.dequeueReusableCell(withReuseIdentifier: "programCell", for: indexPath) as? ProgramCollectionViewCell else {return UICollectionViewCell()}

                return programCell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return (indexPath.section == 0) ? false : true
    }
}

extension HomeNewVC : GetChannelData
{
    func getProgramAt(channelIndex: Int) -> (channelName: String?, programArray: Program?)
    {
       return (filteredList?[channelIndex - 1].callSign, filteredList?[channelIndex - 1].programs)
    }
}
