// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/// @title Job Portal
/// @author Harsh
/// @notice This is a basic job portal where applicants upload
///their infomation and employers find suitable applicant for job.
/// @dev Job portal contract, store applicant information and their
/// rating by employer and employer can view applicants details.

//Errors
contract JobPortal {
    //Events
    event ApplicantAdded();
    event ApplicantAppliedToJob();
    event JobAdded();
    //State variable
    Struct Applicant{
        uint256 id;
        string name;
        uint256 experience;
        string skills;
    }
    Struct Job{
        uint256 id;
        string jobTitle;
        string skills;
    }
    mapping(uint256=>Applicant) applicants;
    mapping(uint256=>Job) jobs;
    mapping(uint256=>uint256[]) applied;
    mapping(uint256=>uint256) ratings;
    address private immutable i_owner;
    //Constructor
    constructor () public {
        i_owner = msg.sender;
    }
    // Modifire
    modifier Admin() {
        require(msg.sender==i_owner,"You are not the Admin");
        _;
    }

    //Functions
    // 1. Add a new applicant
    function addApplicant() public Admin {}

    // 2. Get applicant details
    function getAppDetails() public view returns () {}

    // 3. Get applicant type
    function getAppType() public view returns () {}

    // 4. Add a new Job to the Portal
    function addJob() public {}

    // 5. Get Job details
    function getJob() public view return(){}

    // 6. Applicant apply for a job
    function applyToJob() public {}

    // 7. Provide a rating to an applicant
    function ratingToApp() public {}

    // 8. Fetch applicant rating
    function getAppRating() public view returns () {}
}
