// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

contract VerifySignature {
// function getMessageHash
// function getEthSignedMessageHash
// function verify
//  function recoverSigner
// function splitSignature

// signer = 0xB273216C05A8c0D4F0a4Dd0d7Bae1D2EfFE636dd
//     to = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C
//     amount = 123
//     message = "coffee and donuts"
//     nonce = 1
//     signature = 0x993dab3dd91f5c6dc28e17439be475478f5635c92a56e17e82349d3fb2f166196f466c0b4e0c146f285204f0dcb13e5ae67bc33f4b888ec32dfe0a063e8f3f781b
    
    function getMessageHash(address _to, uint _amount, string memory _message, uint _nonce) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }
    
    function verify() public pure returns (bytes memory) {
        return abi.encodePacked(int16(-1), bytes1(0x42), uint16(0x03), string("Hello, world!"));
    }
}
