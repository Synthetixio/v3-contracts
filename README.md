# v3-contracts
ABI and Adresses for Synthetix v3 contract deployments


#### Install the package:
```bash
npm install @synthetixio/v3-contracts
```
or
```bash
yarn add @synthetixio/v3-contracts
```

## Usage

Get ethers-v5 Contract instance for `CoreProxy` deployed to the `Mainnet`:
```js
const {ethers} = require('ethers');
const meta = require('@synthetixio/v3-contracts/1-main/meta.json');
const abi = require('@synthetixio/v3-contracts/1-main/CoreProxy.readable.json');

const provider = new ethers.providers.JsonRpcProvider(
  process.env.RPC_URL || 'http://127.0.0.1:8545'
);

const CoreProxy = new ethers.Contract(meta.contracts.CoreProxy, abi, provider);

const accountId = 1;
CoreProxy.getAccountOwner(accountId).then(console.log);
```

Dynamically load `CoreProxy` contract for a given chain and preset.

```ts
import {ethers} from 'ethers';

export async function importCoreProxy(chainId: number, preset: string = 'main') {
  switch (`${chainId}-${preset}`) {
    case '1-main':
      const [meta, abi] = await Promise.all([
        import('@synthetixio/v3-contracts/1-main/meta.json'),
        import('@synthetixio/v3-contracts/1-main/CoreProxy.readable.json')
      ]);
      return new ethers.Contract(meta.contracts.CoreProxy, abi, provider);

    case '10-main':
      const [meta, abi] = await Promise.all([
        import('@synthetixio/v3-contracts/10-main/meta.json'),
        import('@synthetixio/v3-contracts/10-main/CoreProxy.readable.json')
      ]);
      return new ethers.Contract(meta.contracts.CoreProxy, abi, provider);

    case '8453-andromeda':
      const [meta, abi] = await Promise.all([
        import('@synthetixio/v3-contracts/8453-andromeda/meta.json'),
        import('@synthetixio/v3-contracts/8453-andromeda/CoreProxy.readable.json')
      ]);
      return new ethers.Contract(meta.contracts.CoreProxy, abi, provider);

    default:
      throw new Error(`Unsupported chain ${chainId} for CoreProxy`);
  }
}

importCoreProxy(1, 'main')
  .then(async CoreProxy => {
    const accountId = 1;
    const address = await CoreProxy.getAccountOwner(accountId);
    console.log(address)
  })
```
