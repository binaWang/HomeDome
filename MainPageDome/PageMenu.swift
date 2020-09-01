//
//  CustomPageMenu.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/8/20.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit
import Then
import SnapKit
struct  MenuConfigModel {
    enum ItemWidthType {
        case autoText
        case width(_ width:CGFloat)
    }
    var itemMargin : CGFloat = 20
    var itemHeight : CGFloat = 60
    var itemSeparatorWidth:CGFloat = 30
    var itemClass : PageMenuItem.Type = PageMenuItemView.self
    var itemWidthAutomaticDimension : Bool = true
    var itemWidthForEach : Bool = false
    var addBottomMenuHairline:Bool = false
    var bottomMenuHairlineColor:UIColor = UIColor.white
    var scrollMenuBackgroundColor:UIColor = UIColor.black
    var selectionIndicatorHidden : Bool = false
    var selectionIndicatorClass : UIView.Type = UIView.self
    var selectionIndicatorColor:UIColor = UIColor.yellow
    var selectionIndicatorHeight: CGFloat = 3
    var selectionIndicatorWidthAutomaticDimension : Bool = true
    var scrollAnimationDurationOnMenuItemTap : TimeInterval = 0.5
}
protocol PageMenuItem : UIView{
    func setData(title:String?,image:UIImage?)
    func normalState()
    func didSelectedState()
    func itemWith()->MenuConfigModel.ItemWidthType
}

protocol CustomPageMenuDelegate:NSObject {
    func willMoveToPage(controller:UIViewController , index:Int)
    func didMoveToPage(controller:UIViewController , index:Int)
}


class PageMenu: UIViewController {
    
    ///  当前滚动方向
    private enum PageMenuScrollDirection {
        case left
        case right
        case other
    }
    
    weak var delegate : CustomPageMenuDelegate?

    /// 配置项
    lazy private(set) var menuItemConfig = MenuConfigModel()
    
    
    /// 当前的 controller数量
    lazy private(set) var  controllerArray : [UIViewController] = []
    
    /// 上部 的标签
    private lazy var menuScrollView :PageMenuScrollView = PageMenuScrollView()
    
    /// 下部 的viewControl
    private lazy var controllerScrollView :PageMenuScrollView = PageMenuScrollView()

    /// 标签数组
    private lazy var  menuItems :  [PageMenuItem] = []
    
    /// 开始滚动的页面序号
    private lazy var  startingPageForScroll :  Int = 0
    
    /// 当前页面的序号
    private lazy var  currentPageIndex :  Int = 0
    
    /// 最后一次滚动的序号
    private lazy var  lastPageIndex :  Int = 0
    
    /// 动画中的页面
    private lazy var  pagesAddedSet :  Set<Int> = []

    /// 开始滚动标记
    private lazy var  didTapMenuItemToScroll :  Bool = false
    
    /// 
    private lazy var didLayoutSubviewsAfterRotation : Bool = false
    
    private lazy var  currentOrientationIsPortrait :  Bool = true
    
    /// 是否滚动过
    private lazy var  didScrollAlready :  Bool = true
    
    /// 点击动画事件
    private var tapTimer:Timer?
    
    private var lastControllerScrollViewContentOffset : CGFloat = 0
    
    private var lastScrollDirection:PageMenuScrollDirection?
    
    private var currentController:UIViewController?

    private var selectionIndicatorView:UIView?
    
    private var selectionIndicatorViewCenterX: Constraint?
    
    
    convenience init(controllers:[UIViewController] ,config:MenuConfigModel? = nil) {
        self.init()
        self.menuItemConfig = config ?? MenuConfigModel()
        self.controllerArray = controllers
        
        setUpUserInterface()
        if menuScrollView.contentView.subviews.count == 0{
            configureUserInterface()
        }
    }
    
    
    func  setUpUserInterface(){
        controllerScrollView.isPagingEnabled = true
        controllerScrollView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(menuScrollView)
        
        
        view.addSubview(controllerScrollView)

        if menuItemConfig.addBottomMenuHairline {
            let  menuBottomHairline = UIView()
            menuBottomHairline.backgroundColor = menuItemConfig.bottomMenuHairlineColor


            menuScrollView.contentView.addSubview(menuBottomHairline)
            menuBottomHairline.snp.makeConstraints { (make) in
                make.leading.equalTo(0)
                make.trailing.equalTo(0)
                make.bottom.equalTo(0)
                make.height.equalTo(0.5)
            }
        }
        
        menuScrollView.showsVerticalScrollIndicator = false
        menuScrollView.showsVerticalScrollIndicator = false
        
        controllerScrollView.showsHorizontalScrollIndicator = false
        controllerScrollView.showsVerticalScrollIndicator = false
        
        menuScrollView.backgroundColor = menuItemConfig.scrollMenuBackgroundColor
        
        menuScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(menuItemConfig.itemHeight)
        }
        menuScrollView.contentView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        controllerScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(menuScrollView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        controllerScrollView.contentView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(controllerArray.count)
        }
        
    }
    func configureUserInterface(){

        menuItems = []
        
        let menuItemTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMenuItemTap(gestureRecognizer:)))
        menuItemTapGestureRecognizer.numberOfTouchesRequired = 1
        menuItemTapGestureRecognizer.numberOfTapsRequired = 1
        menuItemTapGestureRecognizer.delegate = self
        menuScrollView.addGestureRecognizer(menuItemTapGestureRecognizer)
        
        controllerScrollView.delegate = self
        
        menuScrollView.scrollsToTop = false
        controllerScrollView.scrollsToTop = false
        

        var menuItemLeading = menuScrollView.snp.leading
        for (index ,controller) in controllerArray.enumerated(){
            if index == 0{
                controller.viewWillAppear(true)
                self.addPageAtIndex(index: index)
                controller.viewDidAppear(true)
            }
            let titleText = controller.title
            let image = controller.tabBarItem.image

            let item = menuItemConfig.itemClass.init()
            menuScrollView.contentView.addSubview(item)
            item.setData(title: titleText, image: image)
            item.snp.makeConstraints { (make) in
                make.leading.equalTo(menuItemLeading)
                        .offset(menuItemConfig.itemMargin)
                make.top.bottom.equalToSuperview()
                switch item.itemWith(){
                case  .width(let width):
                    make.width.equalTo(width)
                case .autoText:
                    break
                }
                if controllerArray.last == controller{
                    make.trailing.equalToSuperview()
                }
            }
            menuItemLeading = item.snp.trailing
            menuItems.append(item)
            
            
        }

        guard menuItems.count > 0,
        currentPageIndex >= 0,
        currentPageIndex < controllerArray.count else {
            return
        }
        menuItems[currentPageIndex].didSelectedState()
        
        guard menuItemConfig.selectionIndicatorHidden == false else { return }
        
        let indicator = menuItemConfig.selectionIndicatorClass.init()
        indicator.backgroundColor = menuItemConfig.selectionIndicatorColor
        
        menuScrollView.contentView.addSubview(indicator)
        
        indicator.snp.makeConstraints { (make) in
            if menuItemConfig.selectionIndicatorWidthAutomaticDimension{
                make.width.equalTo(menuItems[currentPageIndex].snp.width)
            }else{
                make.width.equalTo(menuItemConfig.itemSeparatorWidth)
            }
            make.height.equalTo(menuItemConfig.selectionIndicatorHeight)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(menuItems[currentPageIndex].snp.centerX)
        }
        selectionIndicatorView = indicator
    }
    
    
    
    @objc private func handleMenuItemTap(gestureRecognizer:UITapGestureRecognizer){
        let tappedPoint = gestureRecognizer.location(in: menuScrollView.contentView)
        
        if let item =   menuScrollView.contentView.hitTest(tappedPoint, with: nil) as? PageMenuItem{
            let itemIndex = (menuItems as NSArray).index(of: item)
            if itemIndex >= 0 , itemIndex < controllerArray.count{
                if itemIndex != currentPageIndex{
                    startingPageForScroll = itemIndex
                    lastPageIndex = currentPageIndex
                    currentPageIndex = itemIndex
                    didTapMenuItemToScroll = true
                    
                    let  smallerIndex = lastPageIndex < currentPageIndex ? lastPageIndex : currentPageIndex
                    let largerIndex = lastPageIndex > currentPageIndex ? lastPageIndex : currentPageIndex
                    
                    if smallerIndex + 1 != largerIndex{
                        for i in smallerIndex..<largerIndex {
                            if !pagesAddedSet.contains(i) {
                                addPageAtIndex(index: i)
                                pagesAddedSet.insert(i)
                            }
                        }
                    }
                    
                    addPageAtIndex(index: itemIndex)
                    
                    pagesAddedSet.insert(lastPageIndex)
                }
                
                UIView.animate(withDuration: menuItemConfig.scrollAnimationDurationOnMenuItemTap) {
                    self.controllerScrollView.contentOffset = CGPoint(x: self.controllerScrollView.bounds.width * CGFloat(itemIndex), y:self.controllerScrollView.contentOffset.y)
                }
                if tapTimer != nil{
                    tapTimer?.invalidate()
                }
                tapTimer = Timer.scheduledTimer(timeInterval: menuItemConfig.scrollAnimationDurationOnMenuItemTap,
                                                target: self,
                                                selector: #selector(scrollViewDidEndTapScrollingAnimation),
                                                userInfo: nil,
                                                repeats: false)
            }
        }
    }

    
    func addPageAtIndex(index:Int){
        guard  index < controllerArray.count , index >= 0 else { return }
        let newVC = controllerArray[index]
        self.delegate?.willMoveToPage(controller: newVC, index: index)
        
        newVC.willMove(toParent: self)
        print(newVC.title ?? "")
        addChild(newVC)
        controllerScrollView.contentView.addSubview(newVC.view)

        newVC.view.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(controllerScrollView.frame.width * CGFloat(index))
            make.top.bottom.equalToSuperview()
            make.width.equalTo(controllerScrollView.snp.width)
        }
        currentController = newVC
        newVC.didMove(toParent: self)
    }
    
    func  removePageAtIndex(index:Int){
        guard  index < controllerArray.count , index >= 0 else { return }

        let oldVC = controllerArray[index]
        oldVC.willMove(toParent: nil)
        oldVC.view.removeFromSuperview()
        oldVC.removeFromParent()
        oldVC.didMove(toParent: nil)
    }

     @objc  func scrollViewDidEndTapScrollingAnimation() {
        let currentController = controllerArray[currentPageIndex]
        delegate?.didMoveToPage(controller: currentController, index: currentPageIndex)
        
        for page in pagesAddedSet{
            if page != currentPageIndex {
                self.removePageAtIndex(index: page)
            }
        }
        
        startingPageForScroll = currentPageIndex
        didTapMenuItemToScroll = false
        pagesAddedSet .removeAll()
    }

    func moveToPage(index:Int){
        if index >= 0, index < controllerArray.count{
            if index != currentPageIndex{
                startingPageForScroll = index
                lastPageIndex = currentPageIndex;
                currentPageIndex = index
                didTapMenuItemToScroll = true
                
                
                let  smallerIndex = lastPageIndex < currentPageIndex ? lastPageIndex : currentPageIndex
                let largerIndex = lastPageIndex > currentPageIndex ? lastPageIndex : currentPageIndex

                if smallerIndex + 1 != largerIndex{
                    for i in smallerIndex..<largerIndex {
                        if !pagesAddedSet.contains(i) {
                            addPageAtIndex(index: i)
                            pagesAddedSet.insert(i)
                        }
                    }
                }
                addPageAtIndex(index: index)
                
                pagesAddedSet.insert(lastPageIndex)

            }
            
            UIView.animate(withDuration: menuItemConfig.scrollAnimationDurationOnMenuItemTap) {
                self.controllerScrollView.contentOffset = CGPoint(x: self.controllerScrollView.bounds.width * CGFloat(index), y:self.controllerScrollView.contentOffset.y)
            }
        }
    }
    func moveSelectionIndicator(index:Int){
        guard  index >= 0, index < controllerArray.count else {
            return
        }
        if menuItemConfig.selectionIndicatorHidden  == false{
            selectionIndicatorView?.snp.remakeConstraints { (make) in
                if menuItemConfig.selectionIndicatorWidthAutomaticDimension{
                    make.width.equalTo(menuItems[currentPageIndex].snp.width)
                }else{
                    make.width.equalTo(menuItemConfig.itemSeparatorWidth)
                }
                make.height.equalTo(menuItemConfig.selectionIndicatorHeight)
                make.bottom.equalToSuperview()
                make.centerX.equalTo(menuItems[currentPageIndex].snp.centerX)
            }
        }
        UIView.animate(withDuration: 0.15) {
            self.menuScrollView.layoutIfNeeded()
            if self.menuItems.count > 0 {
                self.menuItems[self.lastPageIndex].normalState()
                self.menuItems[self.currentPageIndex].didSelectedState()
            }

        }

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let   oldCurrentOrientationIsPortrait  = currentOrientationIsPortrait
        let  orientation = self.getInterfaceOrientation()
       
        currentOrientationIsPortrait = orientation.isPortrait
        if oldCurrentOrientationIsPortrait && orientation.isLandscape || !oldCurrentOrientationIsPortrait && orientation.isPortrait{
            controllerScrollView.superview?.layoutIfNeeded()
            didLayoutSubviewsAfterRotation = true
            
            controllerArray[currentPageIndex].view.snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(controllerScrollView.frame.width * CGFloat(currentPageIndex))
            }

            
            var offsetC = controllerScrollView.contentOffset
            offsetC.x = CGFloat(self.currentPageIndex) * controllerScrollView.frame.width
            self.controllerScrollView.setContentOffset(offsetC, animated: false)

            if menuScrollView.contentSize.width > self.view.frame.width{
                menuScrollView.superview?.layoutIfNeeded()

                let  ratio = (menuScrollView.contentSize.width - self.view.frame.width) / (controllerScrollView.contentSize.width - self.view.frame.width)
                var offset = menuScrollView.contentOffset
                offset.x = controllerScrollView.contentOffset.x * ratio
                menuScrollView.setContentOffset(offset, animated: false)
            }
            
        }
        
        view.layoutIfNeeded()
    }
}


extension PageMenu:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


extension PageMenu : UIScrollViewDelegate{
    func getInterfaceOrientation() -> UIInterfaceOrientation{

        if #available(iOS 13.0, *) {
            return  UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? UIInterfaceOrientation.unknown
        }else{
           return  UIApplication.shared.statusBarOrientation
        }

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard didLayoutSubviewsAfterRotation == false else {
            didLayoutSubviewsAfterRotation = false
            moveSelectionIndicator(index: currentPageIndex)
            return
        }
        
        if scrollView == controllerScrollView{
            if scrollView.contentOffset.x >= 0 ,
                scrollView.contentOffset.x <= CGFloat(controllerArray.count - 1) * self.view.bounds.width{
                
                let  orientation = getInterfaceOrientation()
                
                if ( orientation.isPortrait && currentOrientationIsPortrait) || (!currentOrientationIsPortrait && orientation.isLandscape){
                    
                    if !didTapMenuItemToScroll {
                        if didScrollAlready{
                            var newScrollDirection = PageMenuScrollDirection.other
                            
                            if CGFloat(startingPageForScroll) * scrollView.bounds.width > scrollView.contentOffset.x{
                                newScrollDirection = .right
                            }else if CGFloat(startingPageForScroll) * scrollView.bounds.width < scrollView.contentOffset.x{
                                newScrollDirection = .left
                            }
                            
                            if newScrollDirection != .other{
                                if lastScrollDirection != newScrollDirection{
                                    let index = newScrollDirection == .left ? currentPageIndex + 1 : currentPageIndex - 1
                                    if  index >= 0, index < controllerArray.count  {
                                        if !pagesAddedSet.contains(index){
                                            addPageAtIndex(index: index)
                                            pagesAddedSet.insert(index)
                                        }
                                    }
                                }
                            }
                            
                            lastScrollDirection = newScrollDirection

                            
                        }
                        
                        if !didScrollAlready{
                            if lastControllerScrollViewContentOffset > scrollView.contentOffset.x{
                                
                                if currentPageIndex != controllerArray.count - 1{
                                    let index = currentPageIndex - 1
                                    if !pagesAddedSet.contains(index) ,
                                    index < controllerArray.count ,
                                    index >= 0{
                                        addPageAtIndex(index: index)
                                        pagesAddedSet.insert(index)
                                    }
                                    lastScrollDirection = .right
                                }
                            }else if lastControllerScrollViewContentOffset < scrollView.contentOffset.x{
                                if currentPageIndex != 0{
                                    let index = currentPageIndex + 1
                                    if !pagesAddedSet.contains(index),
                                        index < controllerArray.count ,
                                        index >= 0{
                                        addPageAtIndex(index: index)
                                        pagesAddedSet.insert(index)
                                    }
                                    lastScrollDirection = .left
                                }
                            }
                            didScrollAlready = true
                        }
                        
                        lastControllerScrollViewContentOffset = scrollView.contentOffset.x
                    }
                    
                    var ratio:CGFloat = 1.0
                    ratio = (menuScrollView.contentSize.width - view.frame.width) / (controllerScrollView.contentSize.width - view.frame.width)
                    
                    if menuScrollView.contentSize.width > view.frame.width{
                        var offset = menuScrollView.contentOffset
                        offset.x = controllerScrollView.contentOffset.x * ratio
                        menuScrollView.setContentOffset(offset, animated: false)
                    }
                    
                    let width = controllerScrollView.frame.width
                    
                    /// 可能有问题
                    let page : Int = Int(controllerScrollView.contentOffset.x + ( 0.5 * width)) / Int(width)
                    
                    if page != currentPageIndex{
                        lastPageIndex = currentPageIndex
                        currentPageIndex = page
                        
                        
                        if !pagesAddedSet.contains(page) ,
                            page < controllerArray.count,
                            page >= 0{
                            pagesAddedSet.insert(page)
                        }
                        
                        
                        if !didTapMenuItemToScroll{
                            if !pagesAddedSet .contains(lastPageIndex){
                                pagesAddedSet.insert(lastPageIndex)
                            }
                        }
                        
                        
                        let indexLeftTwo = page - 2
                        if pagesAddedSet.contains(indexLeftTwo){
                            pagesAddedSet.remove(indexLeftTwo)
                            self.removePageAtIndex(index: indexLeftTwo)
                        }
                        let indexrightTwo = page + 2
                       if pagesAddedSet.contains(indexrightTwo){
                           pagesAddedSet.remove(indexrightTwo)
                           self.removePageAtIndex(index: indexrightTwo)
                       }
                        
                    }
                         
                    moveSelectionIndicator(index: page)
                }
                
            }else {
                var ratio:CGFloat = 1.0
                
                ratio = (menuScrollView.contentSize.width - view.frame.width) / (controllerScrollView.contentSize.width  - view.frame.width)
                
                
                if menuScrollView.contentSize.width > view.frame.width{
                    var offset = menuScrollView.contentOffset
                    offset.x = controllerScrollView.contentOffset.x * ratio
                    self.menuScrollView.setContentOffset(offset, animated: false)
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == controllerScrollView else {
            return
        }
        let controller = controllerArray[currentPageIndex]
        delegate?.didMoveToPage(controller: controller, index: currentPageIndex)
        
        
        for num in pagesAddedSet{
            if num != self.currentPageIndex{
                self.removePageAtIndex(index: num)
            }
        }
        
        
        didScrollAlready = false
        startingPageForScroll = currentPageIndex
        pagesAddedSet.removeAll()
    }
}
