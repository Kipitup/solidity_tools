// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

import "hardhat/console.sol";

contract VerifySignature {

    function getMessageHash(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    )
        public pure returns (bytes32)
    {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }
    
    function signMessage(bytes32 _hash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash));
    }
    
    function splitSignature(bytes memory _signature)
        public
        pure
        returns (uint8 v, bytes32 r, bytes32 s)
    {
        require(_signature.length == 65, "Signature length must be 65");
        
        assembly {
            r := mload(add(_signature, 32))
            s := mload(add(_signature, 64))
            v := byte(0, mload(add(_signature, 96)))
        }
        
        return (v, r, s);
    }
    
    function verify(
        address _signer,
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce,
        bytes memory _signature
    )
        public pure returns (bool)
    {
        bytes32 messageHash = getMessageHash(_to, _amount, _message, _nonce);
        bytes32 messageSigned = signMessage(messageHash);
        
        (uint8 v, bytes32 r, bytes32 s) = splitSignature(_signature);
        address recoveredSigner = ecrecover(messageSigned, v, r, s);
        
        return recoveredSigner == _signer;
    }
}
