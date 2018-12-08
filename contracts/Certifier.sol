pragma solidity ^0.4.22;


contract Certifier {
  address public owner;
  string public name;
  mapping(bytes32 => Course) courses;
  bytes32[] courses_codes;

  struct Course {
      string name;
      uint cost;
      uint duration;
      uint threshold;
      bytes32[] codes;
      mapping(address => Student) students;
  }

  struct Student {
      string fname;
      string lname;
      uint age;
      string email;
      bytes32[] codes;
  }

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }

  function isOwner() public view returns (bool) {
    return msg.sender == owner;
  }

  function setName(string _name) public onlyOwner {
    name = _name;
  }

  function getName() public view returns (string) {
    return name;
  }

  function addCourse(
      bytes32 _code,
      string _name,
      uint _cost,
      uint _duration,
      uint _threshold,
      bytes32[] _codes) public onlyOwner {
      courses[_code] = Course({
          name : _name,
          cost : _cost,
          duration : _duration,
          threshold : _threshold,
          codes : _codes
          });
      courses_codes.push(_code);
  }

  function getCourse(bytes32 _code) public view  returns (string, uint, uint, uint, bytes32[]) {
      Course storage course = courses[_code];
      return (course.name, course.cost, course.duration, course.threshold, course.codes);
  }

  function getCourses() public view returns (bytes32[], uint[], uint[], uint[]) {


      bytes32[] memory codes = new bytes32[](courses_codes.length);
      //bytes32[] memory names = new bytes32[](courses_codes.length);
      uint[] memory costs = new uint[](courses_codes.length);
      uint[] memory durations = new uint[](courses_codes.length);
      uint[] memory thresholds = new uint[](courses_codes.length);


      for (uint i = 0; i < courses_codes.length; i++) {
          Course storage course = courses[courses_codes[i]];
          codes[i] = courses_codes[i];
          //names[i] = course.name;
          costs[i] = course.cost;
          durations[i] = course.duration;
          thresholds[i] = course.threshold;
      }

      return (codes, costs, durations, thresholds);
  }

  function subscribe(
      bytes32 _code,
      string _fname,
      string _lname,
      uint _age,
      string _email
  ) public payable {
      require(msg.value == 3 ether, "You haven't sent exactly 3 ether");
      Course storage course = courses[_code];
      course.students[msg.sender] = Student({
          fname : _fname,
          lname : _lname,
          age : _age,
          email : _email,
          codes : new bytes32[](0)
          });
  }
}
