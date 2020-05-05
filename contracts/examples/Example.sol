pragma solidity ^0.6.0;

pragma experimental ABIEncoderV2;

import "../NativeToken.sol";

contract Example is AllowNonDefaultNativeToken {
    mapping (uint256 => uint256) public balance;

    function tryGetCurrentToken() public view returns (uint256) {
        return NativeToken.getCurrentToken();
    }

    function tryGetTokenBalance(address target, uint256 tokenId) public view returns (uint256) {
        if (target == address(0)) {
            target = msg.sender;
        }
        return NativeToken.getTokenBalance(target, tokenId);
    }

    function tryTransferToken(address to, uint256 tokenId, uint256 value) public {
        NativeToken.transferToken(to, tokenId, value, 0);
        balance[tokenId] = NativeToken.getTokenBalance(address(this), tokenId);
    }

    function accept() public payable allowToken {
    }

    // A buggy method which won't succeed.
    function notAccept() public payable {
    }
}
