## Delegate Call Proxy

There are 2 contracts, Store.sol and Proxy.sol.

This is a simple example of using delegate call on Store.sol contract using Proxy.sol.

Proxy.sol will use fallback() because the method function not exist in the contract and then delegate call to Store.sol, matching its method and call data.
Use `forge test --match-test proxySetNumber` to test the fallback() function.

Note that the state used in this is Proxy.sol state not Store.sol state, as I use constructor to assign `num = 20` but Proxy.sol will never have an access to this initial value.
Use `forge test --match-test proxyAssertState` to assert the state between 2 contracts.
