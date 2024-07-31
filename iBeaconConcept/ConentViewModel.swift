//
//  ConenteViewModel.swift
//  iBeaconConcept
//
//  Created by user261874 on 7/28/24.
//

import Foundation
import CoreLocation
import CoreBluetooth

class Beacon {
    var beacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    
    let beaconUUID: UUID!
//    let beaconMajor: CLBeaconMajorValue = 123
//    let beaconMinor: CLBeaconMinorValue = 789
//    
    init(uuid: String) {
        self.beaconUUID = UUID(uuidString: uuid)
    }
}

class ContentViewModel: NSObject, ObservableObject, CBPeripheralManagerDelegate {
    @Published var beaconsToRange: [CLBeaconRegion] = []
    @Published var beacons: [CLBeacon] = []
    private var beaconUuids: [String] = ["",""]
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    var locationManager: CLLocationManager = CLLocationManager()
    @Published var isActive: Bool = false
    @Published var isFilter: Bool = false
    @Published var isSorted: Bool = false


    init(uuids: [String]) {
        super.init()
        self.beaconUuids = uuids
    }
    
    func start() {
        isActive = true
        for uuid in beaconUuids {
            addBeacon(by: uuid)
        }
    }
    
    func stop() {
        isActive = false
        for beacon in beaconsToRange {
            stopBeacon(beacon: beacon)
        }
    }
    
    func sort() {
        isSorted = true
    }

    func addBeacon(by uuid: String) {
        monitorBeacons(by: uuid)
    }

    func initBeacon(with beacon: CLBeaconRegion) {
        if beacon != nil {
            stopBeacon(beacon: beacon)
        }

        let beaconMajor: CLBeaconMajorValue = 1
        let beaconMinor: CLBeaconMinorValue = 1

        let uuid = UUID(uuidString: "uuid")
                
        beaconPeripheralData = beacon.peripheralData(withMeasuredPower: -45)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        
        beaconsToRange.append(beacon)
    }

    func stopBeacon(beacon: CLBeaconRegion) {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        beaconPeripheralData = nil
//        beacon = nil
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(beaconPeripheralData as! [String: AnyObject]?)

        } else if peripheral.state == .poweredOff {
//            stopbeacon()
        }
    }
    
    /// Monitoring beacons from apple codumentation
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
//            enableLocationFeatures()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
//            disableLocationFeatures()
            break
            
        case .notDetermined:        // Authorization not determined yet.
           manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }

    
    func monitorBeacons(by uuid: String = "") {
        if CLLocationManager.isMonitoringAvailable(for:
                      CLBeaconRegion.self) {
            // Match all beacons with the specified UUID

            let beaconID = "com.example.myBeaconRegion"
                
            // Create the region and begin monitoring it.
            let region = CLBeaconRegion(proximityUUID: UUID(uuidString: uuid)!,
                   identifier: beaconID)
            self.locationManager.startMonitoring(for: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                didRangeBeacons beacons: [CLBeacon],
                in region: CLBeaconRegion) {
        
        self.beacons.append(contentsOf: beacons)

        if beacons.count > 0 {
            let nearestBeacon = beacons.first!
//            let major = CLBeaconMajorValue(nearestBeacon.major)
//            let minor = CLBeaconMinorValue(nearestBeacon.minor)
                
            switch nearestBeacon.proximity {
            case .near, .immediate:
                // TODO: To show on screen list
//                displayInformationAboutExhibit(major: major, minor: minor)
                break
                    
            default:
//               dismissExhibit(major: major, minor: minor)
               break
               }
            }
        }
    
    func locationManager(_ manager: CLLocationManager,
                didEnterRegion region: CLRegion) {
        if region is CLBeaconRegion {
            // Start ranging only if the devices supports this service.
            if CLLocationManager.isRangingAvailable() {
                manager.startRangingBeacons(in: region as! CLBeaconRegion)


                // Store the beacon so that ranging can be stopped on demand.
                initBeacon(with: region as! CLBeaconRegion)
//                beaconsToRange.append(region as! CLBeaconRegion)
            }
        }
    }
    
    /// --- Monitoring beacons from apple documentation
}
