// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IERC20} from 'forge-std/interfaces/IERC20.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {IEmissionManager, ITransferStrategyBase, RewardsDataTypes, IEACAggregatorProxy} from '../src/interfaces/IEmissionManager.sol';
import {BaseTest} from './utils/BaseTest.sol';

import {ChangeSdEmissionAdminPayload} from '../src/contracts/ChangeSdEmissionAdminPayload.sol';

contract ChangeSdEmissionAdminTest is BaseTest {

  ChangeSdEmissionAdminPayload public payload;
  address constant GUARDIAN = 0xE50c8C619d05ff98b22Adf991F17602C774F785c;
  IEmissionManager constant EMISSION_MANAGER =
    IEmissionManager(0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 35462470);
    payload = new ChangeSdEmissionAdminPayload();
    _setUp(AaveV3Polygon.ACL_ADMIN);
    _execute(address(payload));
  }

  function testActivation() public {
    /// verify new admin is correctly set
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.SD()), payload.NEW_EMISSION_ADMIN());
    emit log_named_address('new emission admin for SD rewards', EMISSION_MANAGER.getEmissionAdmin(payload.SD()));
    /// verify admin can make changes
    vm.startPrank(payload.NEW_EMISSION_ADMIN());
    EMISSION_MANAGER.setDistributionEnd(payload.SD(), payload.SD(), 0);
    vm.stopPrank();
  }

  function _toUint88(uint256 value) internal pure returns (uint88) {
    require(value <= type(uint88).max, "SafeCast: value doesn't fit in 88 bits");
    return uint88(value);
  }
}
