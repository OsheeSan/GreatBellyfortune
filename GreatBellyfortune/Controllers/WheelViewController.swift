//
//  WheelViewController.swift
//  GreatBellyfortune
//
//  Created by admin on 19.06.2024.
//

import SwiftFortuneWheel
import UIKit

class WheelViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var difficulty: Int!
    
    let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bellymode")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let fortuneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "timewheel")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var prizes1 = [(name: "12", color: #colorLiteral(red: 0.5854218602, green: 0.8424194455, blue: 0.2066773474, alpha: 1)),
                  (name: "12", color: #colorLiteral(red: 0.7690342069, green: 0.1236859187, blue: 0.4755392671, alpha: 1)),
                  (name: "15", color: #colorLiteral(red: 0.9826856256, green: 0.7220065594, blue: 0.05612647533, alpha: 1)),
                  (name: "20", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
                  (name: "12", color: #colorLiteral(red: 0.9794624448, green: 0.6201235652, blue: 0.6958915591, alpha: 1)),
                  (name: "10", color: #colorLiteral(red: 0.4257903695, green: 0.6329038739, blue: 0.156085223, alpha: 1)),
                  (name: "10", color: #colorLiteral(red: 0.570887804, green: 0.1648567915, blue: 0.1432392001, alpha: 1)),
                  (name: "12", color: #colorLiteral(red: 0.9597253203, green: 0.1424967945, blue: 0.004152901471, alpha: 1)),
                  (name: "12", color: #colorLiteral(red: 0.9855783582, green: 0.7895880342, blue: 0.03264886886, alpha: 1)),
                  (name: "15", color: #colorLiteral(red: 0.1296649575, green: 0.5344828367, blue: 0.5237221718, alpha: 1)),
                  (name: "12", color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),]
    
    var times1 = [12,
                 12,
                 15,
                 20,
                 12,
                 10,
                 10,
                 12,
                 12,
                 15,
                 12]
    
    var prizes2 = [(name: "18", color: #colorLiteral(red: 0.5854218602, green: 0.8424194455, blue: 0.2066773474, alpha: 1)),
                  (name: "20", color: #colorLiteral(red: 0.7690342069, green: 0.1236859187, blue: 0.4755392671, alpha: 1)),
                  (name: "18", color: #colorLiteral(red: 0.9826856256, green: 0.7220065594, blue: 0.05612647533, alpha: 1)),
                  (name: "18", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
                  (name: "30", color: #colorLiteral(red: 0.9794624448, green: 0.6201235652, blue: 0.6958915591, alpha: 1)),
                  (name: "18", color: #colorLiteral(red: 0.4257903695, green: 0.6329038739, blue: 0.156085223, alpha: 1)),
                  (name: "20", color: #colorLiteral(red: 0.09231997281, green: 0.4172462225, blue: 0.3689391613, alpha: 1)),
                  (name: "20", color: #colorLiteral(red: 0.958955586, green: 0.2735637724, blue: 0.4815714359, alpha: 1)),
                  (name: "30", color: #colorLiteral(red: 0.1772866547, green: 0.6875243783, blue: 0.6854498386, alpha: 1)),
                  (name: "20", color: #colorLiteral(red: 0.9825684428, green: 0.7300174832, blue: 0, alpha: 1)),
                  (name: "18", color: #colorLiteral(red: 0.570887804, green: 0.1648567915, blue: 0.1432392001, alpha: 1)),
                  (name: "22", color: #colorLiteral(red: 0.9597253203, green: 0.1424967945, blue: 0.004152901471, alpha: 1)),
                  (name: "18", color: #colorLiteral(red: 0.9231320024, green: 0.2861315608, blue: 0.5029468536, alpha: 1))]
    
    var times2 = [18,20,18,18,30,18,20,20,30,20,18,22,18]
    
    var prizes3 = [(name: "90", color: #colorLiteral(red: 0.5854218602, green: 0.8424194455, blue: 0.2066773474, alpha: 1)),
                  (name: "90", color: #colorLiteral(red: 0.7690342069, green: 0.1236859187, blue: 0.4755392671, alpha: 1)),
                  (name: "50", color: #colorLiteral(red: 0.9826856256, green: 0.7220065594, blue: 0.05612647533, alpha: 1)),
                  (name: "40", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)),
                  (name: "Secret Mask", color: #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)),
                  (name: "70", color: #colorLiteral(red: 0.9794624448, green: 0.6201235652, blue: 0.6958915591, alpha: 1)),
                  (name: "40", color: #colorLiteral(red: 0.4257903695, green: 0.6329038739, blue: 0.156085223, alpha: 1)),
                  (name: "50", color: #colorLiteral(red: 0.09231997281, green: 0.4172462225, blue: 0.3689391613, alpha: 1)),
                  (name: "60", color: #colorLiteral(red: 0.958955586, green: 0.2735637724, blue: 0.4815714359, alpha: 1)),
                  (name: "40", color: #colorLiteral(red: 0.1772866547, green: 0.6875243783, blue: 0.6854498386, alpha: 1)),
                  (name: "40", color: #colorLiteral(red: 0.9825684428, green: 0.7300174832, blue: 0, alpha: 1)),
                  (name: "100", color: #colorLiteral(red: 0.570887804, green: 0.1648567915, blue: 0.1432392001, alpha: 1)),
                  (name: "60", color: #colorLiteral(red: 0.9597253203, green: 0.1424967945, blue: 0.004152901471, alpha: 1)),
                  (name: "100", color: #colorLiteral(red: 0.9231320024, green: 0.2861315608, blue: 0.5029468536, alpha: 1)),
                  (name: "70", color: #colorLiteral(red: 0.9855783582, green: 0.7895880342, blue: 0.03264886886, alpha: 1)),
                  (name: "80", color: #colorLiteral(red: 0.1296649575, green: 0.5344828367, blue: 0.5237221718, alpha: 1)),
                  (name: "40", color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),
                  (name: "40", color: #colorLiteral(red: 0.1332196295, green: 0.4960685372, blue: 0.7784749269, alpha: 1)),
                  (name: "40", color: #colorLiteral(red: 0.05485288054, green: 0.2538931668, blue: 0.461497426, alpha: 1))]
    
    var times3 = [90,
                 90,
                 50,
                 40,
                 0,
                 70,
                 40,
                 50,
                 60,
                 40,
                 40,
                 100,
                 60,
                 100,
                 70,
                 80,
                 40,
                 40,
                 40]
    
    lazy var slices: [Slice] = {
        
        var slices: [Slice] = []
        
        var prizes: [(name: String, color: UIColor)] = {
            switch  difficulty {
            case 1:
                return prizes1
            case 2:
                return prizes2
            case 3:
                return prizes3
            default:
                return prizes1
            }
        }()
        
        for prize in prizes {
            let sliceContent = [Slice.ContentType.text(text: prize.name, preferences: .variousWheelJackpotText)]
            let slice = Slice(contents: sliceContent, backgroundColor: prize.color)
            slices.append(slice)
        }

        return slices
        
    }()
    
    lazy var fortuneWheel: SwiftFortuneWheel = {
        let frame = CGRect(x: 35, y: 100, width: 300, height: 300)
        let fortuneWheel = SwiftFortuneWheel(frame: frame, slices: slices, configuration: .variousWheelJackpotConfiguration)
        fortuneWheel.configuration = .variousWheelJackpotConfiguration
        fortuneWheel.spinImage = "redCenterImage"
        fortuneWheel.pinImage = "redArrowWheel"
        return fortuneWheel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "bg_1")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 70),
        ])
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        view.addSubview(fortuneWheel)
        layoutWheel()
        view.addSubview(welcomeImageView)
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            welcomeImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            welcomeImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            welcomeImageView.bottomAnchor.constraint(equalTo: fortuneWheel.topAnchor)
        ])
        
        view.addSubview(fortuneImageView)
        NSLayoutConstraint.activate([
            fortuneImageView.topAnchor.constraint(equalTo: fortuneWheel.bottomAnchor),
            fortuneImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            fortuneImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            fortuneImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    deinit {
        fortuneWheel.stopRotation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let prizes: [(name: String, color: UIColor)] = {
            switch  difficulty {
            case 1:
                return prizes1
            case 2:
                return prizes2
            case 3:
                return prizes3
            default:
                return prizes1
            }
        }()
        let finishIndex = Int.random(in: 0..<prizes.count)
        fortuneWheel.startRotationAnimation(finishIndex: finishIndex, continuousRotationTime: 2) { (finished) in
            if finished {
                let vc = BellyGameController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.difficulty = self.difficulty
                if finishIndex != 4 {
                    switch self.difficulty {
                        case 1:
                            vc.allTime = self.times1[finishIndex]
                        case 2:
                            vc.allTime = self.times2[finishIndex]
                        case 3:
                            vc.allTime = self.times3[finishIndex]
                        default:
                            vc.allTime = self.times1[finishIndex]
                        }
                    self.present(vc, animated: true)
                } else {
                    vc.allTime = 50
                    if BellyManager.getMaskCount() < 3 {
                        BellyManager.findMask()
                        self.showAlert(title: "Yeah!", message: "New mask is available in the shop!", action: {_ in 
                            self.present(vc, animated: true)
                        })
                    } else {
                        self.showAlert(title: "Oops!", message: "You've already have all masks!", action: {_ in 
                            self.present(vc, animated: true)
                        })
                    }
                }
            }
        }
    }
    
    func showAlert(title: String, message: String, action: @escaping (UIAlertAction) -> ()) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: action)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    
    func layoutWheel() {
        fortuneWheel.translatesAutoresizingMaskIntoConstraints = false
        fortuneWheel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        fortuneWheel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        fortuneWheel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        fortuneWheel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

public extension SFWConfiguration {
    static var variousWheelJackpotConfiguration: SFWConfiguration {
        let anchorImage = SFWConfiguration.AnchorImage(imageName: "blueAnchorImage", size: CGSize(width: 12, height: 12), verticalOffset: -22)
        
        let pin = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 40, height: 40), position: .top, verticalOffset: -25)
        
        let spin = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 20, height: 20))
        
        let sliceColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 0, strokeColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 15, strokeColor: .orange)
        
        var wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences, slicePreferences: slicePreferences, startPosition: .top)
        
        wheelPreferences.centerImageAnchor = anchorImage
        
        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences, pinPreferences: pin, spinButtonPreferences: spin)
        
        return configuration
    }
}

public extension TextPreferences {
    static var variousWheelJackpotText: TextPreferences {
        
        let font = UIFont(name: "Avenir-Black", size: 13) ?? UIFont.systemFont(ofSize: 13)
        let horizontalOffset: CGFloat = 2
        
        
        var textPreferences = TextPreferences(textColorType: SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white),
                                              font: font,
                                              verticalOffset: 5)
        
        textPreferences.horizontalOffset = horizontalOffset
        textPreferences.orientation = .vertical
        textPreferences.alignment = .right
        
        return textPreferences
    }
}
