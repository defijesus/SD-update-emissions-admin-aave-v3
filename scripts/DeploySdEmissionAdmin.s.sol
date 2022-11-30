// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {ChangeSdEmissionAdminPayload} from '../src/contracts/ChangeSdEmissionAdminPayload.sol';

contract DeploySdEmissionAdmin is Script {
  function run() external {
    vm.startBroadcast();
    ChangeSdEmissionAdminPayload payload = new ChangeSdEmissionAdminPayload();
    console.log('SD Emission Admin Payload address', address(payload));
    vm.stopBroadcast();
  }
}