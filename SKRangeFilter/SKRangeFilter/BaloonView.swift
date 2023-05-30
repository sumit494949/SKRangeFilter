//
//  BaloonView.swift
//

import UIKit

final class BaloonView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var valueLbl: UILabel!
    
    @IBOutlet weak var imgVw: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib(){
        let nibToLoad = "BaloonView"
        
        let bundle = Bundle(for: BaloonView.self)
        bundle.loadNibNamed(nibToLoad, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        customiseView()
        
    }
    
    private func customiseView(){
        imgVw.image = UIImage(named: "balloon")
    }
}
