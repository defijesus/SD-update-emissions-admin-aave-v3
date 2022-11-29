// SPDX-License-Identifier: MIT

/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/

pragma solidity ^0.8.0;

import {IEmissionManager} from '../interfaces/IEmissionManager.sol';
import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';

/**
 * @title AddEmissionAdminPayload
 * @author Llama
 * @dev Setting new Emssion Admin for SD token in Aave V3 Polygon Liquidity Pool
 * Governance Forum Post: https://governance.aave.com/t/arc-sd-emission-admin-for-polygon-v3-liquidity-pool/10658
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x58c20dae66638085b5e834cd66ef560a34a71cad88cb1866fb9a726a1fb1861a
 */
contract ChangeSdEmissionAdminPayload is IProposalGenericExecutor {
  address public constant EMISSION_MANAGER = 0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73;

  address public constant SD = 0x1d734A02eF1e1f5886e66b0673b71Af5B53ffA94;

  address public constant NEW_EMISSION_ADMIN = 0x51358004cFe135E64453d7F6a0dC433CAba09A2a;

  function execute() public {
    IEmissionManager(EMISSION_MANAGER).setEmissionAdmin(SD, NEW_EMISSION_ADMIN);
  }
}
