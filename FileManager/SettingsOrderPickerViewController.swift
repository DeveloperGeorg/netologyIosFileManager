import UIKit

class SettingsOrderPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let defaults = UserDefaults.standard
    let settingsDataProvider:SettingsDataProviderProtocol = UserDefaultsSettingsDataProvider()
    @IBOutlet weak var orderPickerView: UIPickerView!
    let pickerDat: [String] = FolderOrderEnum.allCases.map { $0.rawValue }
    var choseOrder:String = FolderOrderEnum.inAlphabetical.rawValue
    override func viewDidLoad() {
        super.viewDidLoad()
        orderPickerView.delegate = self
        orderPickerView.dataSource = self
        if let savedValue = settingsDataProvider.getFolderOrder() {
            choseOrder = savedValue.rawValue
        }
        guard let indexOfChoseOrder = pickerDat.firstIndex(of: choseOrder) else { return  }
        orderPickerView.selectRow(indexOfChoseOrder, inComponent:0, animated:true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            choseOrder = pickerDat[row]
            return choseOrder
        }

    @IBAction func chooseOrder(_ sender: Any) {
        print(choseOrder)
        settingsDataProvider.setFolderOrder(FolderOrderEnum(rawValue: choseOrder) ?? FolderOrderEnum.inAlphabetical)
        _ = navigationController?.popViewController(animated: true)
    }
}
