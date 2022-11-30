# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv

deploy-payload :; forge script scripts/DeploySdEmissionAdmin.s.sol:DeploySdEmissionAdmin --rpc-url ${RPC_POLYGON} --broadcast --ledger --sender ${LEDGER_SENDER} --verify --chain 137 --etherscan-api-key ${POLYGONSCAN_API_KEY} -vvvv

verify-payload :; forge verify-contract --chain-id 137 --watch [DEPLOYED ADDRESS] ./src/contracts/ChangeSdEmissionAdminPayload.sol:ChangeSdEmissionAdminPayload ${POLYGONSCAN_API_KEY}

submit-proposal :; forge script scripts/DeployL1PolygonProposal.s.sol:DeploySd --rpc-url ${RPC_ETHEREUM} --broadcast --private-key ${PRIVATE_KEY} -vvvv