//
//  TintImageView.swift
//  Nice
//
//  Created by yang on 16/3/21.
//  Copyright © 2016年 yang. All rights reserved.
//

import UIKit

class TintImageView: UIImageView
{
    override func awakeFromNib()
    {
        self.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    }

}
