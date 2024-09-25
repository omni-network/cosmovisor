# cosmovisor

This is a fork
of CosmosSDK's [Cosmovisor](https://github.com/cosmos/cosmos-sdk/tree/main/tools/cosmovisor) of this [commit](https://github.com/cosmos/cosmos-sdk/commit/d54f6fa95b4aa61efada936b83161d0302faccdd) 
on branch `main`. It basically adds some flags to override the default folder structure, similar to [#16550](https://github.com/cosmos/cosmos-sdk/pull/16550)
with the aim to run Cosmovisor inside a docker container; see Omni's [halovisor](https://github.com/omni-network/omni/tree/main/scripts/halovisor) 
for more details.

It adds the following flags:
- `COSMOVISOR_CUSTOM_ROOT`: Allows overriding the default root folder `DEAMON_HOME/cosmovisor` containing all cosmovisor data.
- `COSMOVISOR_CUSTOM_CURRENT_LINK`: Allows overriding the default current link `DEAMON_HOME/cosmovisor/current`.

Problems it solves:
- The default cosmovisor folder structure makes it hard to run cosmovisor inside a docker container.
- The current link should be mountable, so that it is retained between container restarts.
- A single external mount with all external data simplifies the setup.
- Since root is hard coded to `DEAMON_HOME/cosmovisor`, it clashes with the default `DEAMON_HOME/config` and `DEAMON_HOME/data` folders.
- The current link is hard coded to `DEAMON_HOME/cosmovisor/current`, which is not mountable.

# How to create this fork
```
mkdir temp-cosmos-sdk
cd temp-cosmos-sdk/
git init
git remote add -f upstream git@github.com:cosmos/cosmos-sdk.git
git config core.sparseCheckout true
echo "tools/cosmovisor/" >> .git/info/sparse-checkout
git pull upstream main
cd tools/cosmovisor/
git init
git remote add origin git@github.com:omni-network/cosmovisor.git
git add .
git commit -am "fork from upstream"
git push -u origin main -f
# Modify the code
git commit -am "Add custom flags"
git push
```
