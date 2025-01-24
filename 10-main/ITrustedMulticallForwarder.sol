// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ITrustedMulticallForwarder {
    error AddressInsufficientBalance(address account);
    error ERC2771ForwarderExpiredRequest(uint48 deadline);
    error ERC2771ForwarderInvalidSigner(address signer, address from);
    error ERC2771ForwarderMismatchedValue(uint256 requestedValue, uint256 msgValue);
    error ERC2771UntrustfulTarget(address target, address forwarder);
    error FailedInnerCall();
    error InvalidAccountNonce(address account, uint256 currentNonce);
    error InvalidShortString();
    error StringTooLong(string str);
    event EIP712DomainChanged();
    event ExecutedForwardRequest(address indexed signer, uint256 nonce, bool success);
    function aggregate(TrustedMulticallForwarder.Call[] memory calls) external returns (uint256 blockNumber, bytes[] memory returnData);
    function aggregate3(TrustedMulticallForwarder.Call3[] memory calls) external payable returns (TrustedMulticallForwarder.Result[] memory returnData);
    function aggregate3Value(TrustedMulticallForwarder.Call3Value[] memory calls) external payable returns (TrustedMulticallForwarder.Result[] memory returnData);
    function blockAndAggregate(TrustedMulticallForwarder.Call[] memory calls) external payable returns (uint256 blockNumber, bytes32 blockHash, TrustedMulticallForwarder.Result[] memory returnData);
    function eip712Domain() external view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
    function execute(ERC2771Forwarder.ForwardRequestData memory request) external payable;
    function executeBatch(ERC2771Forwarder.ForwardRequestData[] memory requests) external payable returns (TrustedMulticallForwarder.Result[] memory returnData);
    function executeBatch(ERC2771Forwarder.ForwardRequestData[] memory requests, address refundReceiver) external payable;
    function getBasefee() external view returns (uint256 basefee);
    function getBlockHash(uint256 blockNumber) external view returns (bytes32 blockHash);
    function getBlockNumber() external view returns (uint256 blockNumber);
    function getChainId() external view returns (uint256 chainid);
    function getCurrentBlockCoinbase() external view returns (address coinbase);
    function getCurrentBlockGasLimit() external view returns (uint256 gaslimit);
    function getCurrentBlockTimestamp() external view returns (uint256 timestamp);
    function getEthBalance(address addr) external view returns (uint256 balance);
    function getLastBlockHash() external view returns (bytes32 blockHash);
    function getPrevRandao() external view returns (uint256 prevrandao);
    function nonces(address owner) external view returns (uint256);
    function tryAggregate(bool requireSuccess, TrustedMulticallForwarder.Call[] memory calls) external returns (TrustedMulticallForwarder.Result[] memory returnData);
    function tryBlockAndAggregate(bool requireSuccess, TrustedMulticallForwarder.Call[] memory calls) external payable returns (uint256 blockNumber, bytes32 blockHash, TrustedMulticallForwarder.Result[] memory returnData);
    function verify(ERC2771Forwarder.ForwardRequestData memory request) external view returns (bool);
}

interface TrustedMulticallForwarder {
    struct Call {
        address target;
        bytes callData;
    }

    struct Call3 {
        address target;
        bool requireSuccess;
        bytes callData;
    }

    struct Result {
        bool success;
        bytes returnData;
    }

    struct Call3Value {
        address target;
        bool requireSuccess;
        uint256 value;
        bytes callData;
    }
}

interface ERC2771Forwarder {
    struct ForwardRequestData {
        address from;
        address to;
        uint256 value;
        uint256 gas;
        uint48 deadline;
        bytes data;
        bytes signature;
    }
}
