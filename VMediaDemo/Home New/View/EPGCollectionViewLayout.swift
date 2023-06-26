//  CustomCollectionViewLayout.swift
//
//  Created by Ravindra Arya on 6/22/23.
//
import UIKit

protocol GetChannelData
{
    func getProgramAt(channelIndex : Int)-> (channelName : String?, programArray : Program?)
}

class CustomCollectionViewLayout: UICollectionViewLayout {

    var itemAttributes = [[UICollectionViewLayoutAttributes]]()
    var itemsSize = [[CGSize]]()
    var contentSize: CGSize = .zero
    var delegate : GetChannelData!

    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }

        let headerview = collectionView.viewWithTag(1019)


        if collectionView.numberOfSections == 0 {
            return
        }

        if itemAttributes.count != collectionView.numberOfSections {
            generateItemAttributes(collectionView: collectionView)
            return
        }

        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                if section != 0 && item != 0 {
                    continue
                }

                let attributes = layoutAttributesForItem(at: IndexPath(item: item, section: section))!
                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = collectionView.contentOffset.y
                    attributes.frame = frame

                    var frame1 = headerview?.frame
                    frame1!.origin.y = collectionView.contentOffset.y
                    headerview!.frame = frame1!
                }

                if item == 0 {
                    var frame = attributes.frame
                    frame.origin.x = collectionView.contentOffset.x
                    attributes.frame = frame

                    var frame1 = headerview?.frame
                    frame1!.origin.x = collectionView.contentOffset.x
                    headerview!.frame = frame1!
                }
            }
        }

    }

    override var collectionViewContentSize: CGSize
    {
        return contentSize
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath.section][indexPath.item]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in itemAttributes {
            let filteredArray = section.filter { obj -> Bool in
                return rect.intersects(obj.frame)
            }

            attributes.append(contentsOf: filteredArray)
        }

        return attributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

// MARK: - Helpers
extension CustomCollectionViewLayout {

    func generateItemAttributes(collectionView: UICollectionView)
    {
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var maxX: CGFloat = 0

        itemAttributes = []
        itemsSize = []

        for section in 0..<collectionView.numberOfSections
        {
            var dataArrayAtSection : (channelName : String?, programArray : Program?)
            dataArrayAtSection = ((section == 0) ? ("",[]) : delegate.getProgramAt(channelIndex: section))
            calculateItemSizes(section: section, dataArray: (dataArrayAtSection.programArray))
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []

            let loopCount = (section == 0) ? daysData : (dataArrayAtSection.programArray?.count ?? 0)

            for item in 0...(loopCount) {
                let itemSize = itemsSize[section][item]
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

                if item == 1 && section != 0{}

                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral

                if section == 0 && item == 0 {
                    // First cell should be on top
                    attributes.zIndex = 1024
                } else if section == 0 || item == 0 {
                    // First row/column should be above other cells
                    attributes.zIndex = 1022
                }
                let headerview = collectionView.viewWithTag(1019)
                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = collectionView.contentOffset.y
                    attributes.frame = frame
                    var frame1 = headerview?.frame
                    frame1!.origin.y = collectionView.contentOffset.y
                    headerview!.frame = frame1!
                }

                if item == 0 {
                    var frame = attributes.frame
                    frame.origin.x = collectionView.contentOffset.x
                    attributes.frame = frame
                    var frame1 = headerview?.frame
                    frame1!.origin.x = collectionView.contentOffset.x
                    headerview!.frame = frame1!
                }

                sectionAttributes.append(attributes)

                xOffset += itemSize.width
                if item == ((section == 0) ? daysData : (dataArrayAtSection.programArray?.count))
                {
                    xOffset = 0
                    yOffset += itemSize.height
                }
            }

            itemAttributes.append(sectionAttributes)
        }

        if let attributes = itemAttributes.last?.last
        {
            maxX = (attributes.frame.maxX > maxX) ? attributes.frame.maxX : maxX
            contentSize = CGSize(width: maxX + 50, height: attributes.frame.maxY)
        }
    }

    func calculateItemSizes(section : Int,dataArray : Program?)
    {
        var arrayOfCGSize = [CGSize]()
        let loopCount = (section == 0) ? daysData : (dataArray?.count ?? 0)

        for item in 0...(loopCount)
        {
            if section == 0 || item == 0
            {
                arrayOfCGSize.append(sizeForItemWithColumnIndex(section: section, item: item))
            }
            else
            {
                arrayOfCGSize.append(sizeForItemWithColumnIndex(section: section, item: item, programData: dataArray?[item-1]))
            }
        }
        itemsSize.append(arrayOfCGSize)
    }

    func sizeForItemWithColumnIndex(section: Int,item: Int, programData : ProgramElement? = nil) -> CGSize
    {
        var width: CGFloat
        var height = TILE_HEIGHT
        if item == 0 && section == 0
        {
            width = 297
            height = 58
        }
        else if section == 0
        {
            width = 408
            height = 58
        }
        else if item == 0
        {
            width = 297
        }
        else
        {
            let startTime = Utility.convertDateTimeStringToDate(string: programData?.startTime ?? "")
            let endTime = startTime.addingTimeInterval(TimeInterval((programData?.length ?? 0) * 60))
            width = Utility.getProgrammWidth(start: endTime, end: startTime)
        }
        return CGSize(width: width, height: height)
    }
}
