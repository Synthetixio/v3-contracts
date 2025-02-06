// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IOracleManagerProxy {
    function facets() external pure returns (S_0[] memory);
    function facetFunctionSelectors(address facet) external pure returns (bytes4[] memory functionSelectors);
    function facetAddresses() external pure returns (address[] memory addresses);
    function facetAddress(bytes4 functionSelector) external pure returns (address);
    function emitDiamondCutEvent() external returns (bool);
    error ImplementationIsSterile(address implementation);
    error NoChange();
    error NotAContract(address contr);
    error NotNominated(address addr);
    error Unauthorized(address addr);
    error UpgradeSimulationFailed();
    error ZeroAddress();
    event OwnerChanged(address oldOwner, address newOwner);
    event OwnerNominated(address newOwner);
    event Upgraded(address indexed self, address implementation);
    function acceptOwnership() external;
    function getImplementation() external view returns (address);
    function nominateNewOwner(address newNominatedOwner) external;
    function nominatedOwner() external view returns (address);
    function owner() external view returns (address);
    function renounceNomination() external;
    function simulateUpgradeTo(address newImplementation) external;
    function upgradeTo(address newImplementation) external;
    error EmptyRevertReason();
    error Errors(bytes[] errors);
    error InvalidNodeDefinition(NodeDefinition.Data nodeType);
    error InvalidParameter(string parameter, string reason);
    error InvalidPrice(int256 price);
    error NodeNotRegistered(bytes32 nodeId);
    error OracleDataRequired(address oracleContract, bytes oracleQuery);
    error OverflowInt256ToUint256();
    error OverflowInt56ToInt24();
    error OverflowUint256ToInt256();
    error OverflowUint256ToUint160();
    error OverflowUint56ToInt56();
    event NodeRegistered(bytes32 nodeId, uint8 nodeType, bytes parameters, bytes32[] parents);
    function getNode(bytes32 nodeId) external pure returns (NodeDefinition.Data memory node);
    function getNodeId(uint8 nodeType, bytes memory parameters, bytes32[] memory parents) external pure returns (bytes32 nodeId);
    function process(bytes32 nodeId) external view returns (NodeOutput.Data memory node);
    function processManyWithManyRuntime(bytes32[] memory nodeIds, bytes32[][] memory runtimeKeys, bytes32[][] memory runtimeValues) external view returns (NodeOutput.Data[] memory nodes);
    function processManyWithRuntime(bytes32[] memory nodeIds, bytes32[] memory runtimeKeys, bytes32[] memory runtimeValues) external view returns (NodeOutput.Data[] memory nodes);
    function processWithRuntime(bytes32 nodeId, bytes32[] memory runtimeKeys, bytes32[] memory runtimeValues) external view returns (NodeOutput.Data memory node);
    function registerNode(uint8 nodeType, bytes memory parameters, bytes32[] memory parents) external returns (bytes32 nodeId);
}

interface NodeDefinition {
    struct Data {
        uint8 nodeType;
        bytes parameters;
        bytes32[] parents;
    }
}

interface NodeOutput {
    struct Data {
        int256 price;
        uint256 timestamp;
        uint256 __slotAvailableForFutureUse1;
        uint256 __slotAvailableForFutureUse2;
    }
}

struct S_0 {
    address facetAddress;
    bytes4[] functionSelectors;
}
