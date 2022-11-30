// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {IEmissionManager} from '../src/interfaces/IEmissionManager.sol';
import {BaseTest} from './utils/BaseTest.sol';

import {ChangeSdEmissionAdminPayload} from '../src/contracts/ChangeSdEmissionAdminPayload.sol';

contract ChangeSdEmissionAdminTest is BaseTest {

  ChangeSdEmissionAdminPayload public payload;
  IEmissionManager constant EMISSION_MANAGER =
    IEmissionManager(0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'));
    payload = ChangeSdEmissionAdminPayload(0x0DcDA7E9e5c5Ecd43bf047eA39B9833C3f42BA11);
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
}
