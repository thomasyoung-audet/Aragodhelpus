pragma solidity >=0.4.22 <0.6.0;


import "@aragon/os/contracts/apps/AragonApp.sol";

contract ride is AragonApp {
    
    // Members
    struct Ride {
        string endPoint;
        string startPoint;
        string date; 
        string car;
        uint8 capacity;
        uint8 price; 
    }
    
    struct Rider {
        address private_key;
        address public_key;
    }

    Rider[] public riders;

    // Roles
    bytes32 constant public DRIVER_ROLE = keccak256("DRIVER_ROLE");
    bytes32 constant public RIDER_ROLE = keccak256("RIDER_ROLE");
    
    bool rideStarted;
    uint8 capacity;
    uint8 numRiders;
    Ride currentRide; 
    address public driver;

    constructor(string endPoint, string startPoint, string date, string car, uint8 car_capacity, uint8 price) public { 
        driver = msg.sender; 
        currentRide = Ride({endPoint: endPoint, startPoint: startPoint, car: car, date: date, capacity: car_capacity, price: price});
        rideStarted = false;
        numRiders = 0; 
    }
    
    // Events
    event JoinRide(address indexed entity ,address private_key, address public_key);
    event RideStart(address indexed entity);
    event RideFinish(address indexed entity);
    
    //Functions
    function joinRide(address privateKey, address publicKey) auth(RIDER_ROLE) external {
        bool breaker = false;
        if (numRiders == capacity) breaker = true;
        
        if (breaker == false) {
            Rider memory newrider = Rider(privateKey, publicKey);
            riders.push(newrider);
            numRiders += 1; 
        }
    }
    
    function rideStart() auth(DRIVER_ROLE) internal {
        rideStarted = true; 
    }
    
    function rideFinish() auth(DRIVER_ROLE) internal {
        // Close contract
        // Payment to driver
        
        selfdestruct(driver);
    }
    
}
