// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// @title Job Portal
/// @author Harsh
/// @notice This is a basic job portal where applicants upload
///their infomation and employers find suitable applicant for job.
/// @dev Job portal contract, store applicant information and their
/// rating by employer and employer can view applicants details.

//Errors
contract JobPortal {
    //Events
    event ApplicantAdded(
        uint256 indexed Id,
        string indexed name,
        string skills
    );
    event JobAdded(
        uint256 indexed _id,
        string indexed title,
        string indexed skills
    );
    // event ApplicantAppliedToJob();
    //State variable
    struct Applicant {
        uint256 id;
        string name;
        uint256 experience;
        string skills;
        string history;
        bool skilled;
    }
    struct Job {
        uint256 id;
        string jobTitle;
        string skills;
    }
    mapping(uint256 => Applicant) public applicants;
    mapping(uint256 => Job) public jobs;
    mapping(uint256 => uint256[]) public applied;
    mapping(uint256 => uint256) public ratings;
    address public immutable i_owner;

    //Constructor
    constructor() {
        i_owner = msg.sender;
    }

    // Modifire
    modifier Admin() {
        require(msg.sender == i_owner, "You are not the Admin");
        _;
    }

    //Functions
    // 1. Add a new applicant
    function addApplicant(
        uint256 _id,
        string memory name,
        uint256 experience,
        string memory skills,
        string memory history,
        bool skilled
    ) public Admin {
        Applicant memory applicant = Applicant(
            _id,
            name,
            experience,
            skills,
            history,
            skilled
        );
        applicants[_id] = applicant;
        emit ApplicantAdded(_id, name, skills);
    }

    // 2. Get applicant details
    function getAppDetails(uint256 _id) public view returns (Applicant memory) {
        return applicants[_id];
    }

    // // 3. Get applicant type
    function getAppType(uint256 _id) public view returns (string memory) {
        if (applicants[_id].skilled) return "skilled";
        else return "unskilled";
    }

    // 4. Add a new Job to the Portal
    function addJob(
        uint256 _id,
        string memory title,
        string memory skills
    ) public {
        Job memory job = Job(_id, title, skills);
        jobs[_id] = job;
        emit JobAdded(_id, title, skills);
    }

    // 5. Get Job details
    function getJob(uint256 _id) public view returns (Job memory) {
        return jobs[_id];
    }

    // 6. Applicant apply for a job
    function applyToJob(uint256 _jobId, uint256 _appId) public {
        applied[_jobId].push(_appId);
    }

    // // 7. Provide a rating to an applicant
    function ratingToApp(uint256 _id, uint256 rating) public {
        uint256 newRating = (rating + ratings[_id]) / 2;
        ratings[_id] = newRating;
    }

    // // 8. Fetch applicant rating
    function getAppRating(uint256 _id) public view returns (uint256) {
        return ratings[_id];
    }
}
