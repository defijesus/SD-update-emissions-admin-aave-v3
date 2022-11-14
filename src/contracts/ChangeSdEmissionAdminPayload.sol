// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEmissionManager} from '../interfaces/IEmissionManager.sol';
import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';

/**
 * @title AddEmissionAdminPayload
 * @author BGD Labs
 * @dev Generic proposal to be executed via cross-chain governance.
 * Once executed this payload would add an EMISSION_ADMIN for a REWARD token on the specified EMISSION_MANAGER.
 */
contract ChangeSdEmissionAdminPayload is IProposalGenericExecutor {
  address public constant EMISSION_MANAGER = 0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73;

  address public constant SD = 0x1d734A02eF1e1f5886e66b0673b71Af5B53ffA94;

  address public constant NEW_EMISSION_ADMIN = 0x51358004cFe135E64453d7F6a0dC433CAba09A2a;

  function execute() public {
    IEmissionManager(EMISSION_MANAGER).setEmissionAdmin(SD, NEW_EMISSION_ADMIN);
  }
}
